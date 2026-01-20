import 'dart:io';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/api/api_cache.dart';
import 'package:tin_flutter_scafflod/api/api_config.dart';
import 'package:tin_flutter_scafflod/api/api_response.dart';
import 'package:tin_flutter_scafflod/service/oauth_service.dart';
import 'package:tin_flutter_scafflod/utils/logger.dart';

/// 基于 GetConnect 的增强客户端：支持重试、缓存、错误处理
class ApiClient extends GetConnect {
  static const int _maxRetries = 3;

  ApiClient() {
    final timeoutMs = ApiConfig.connectTimeoutMs > ApiConfig.receiveTimeoutMs
        ? ApiConfig.connectTimeoutMs
        : ApiConfig.receiveTimeoutMs;
    httpClient
      ..baseUrl = ApiConfig.baseUrl
      ..maxAuthRetries = 0
      ..timeout = Duration(milliseconds: timeoutMs)
      ..addRequestModifier<Object?>((request) {
        final token = _token;
        if (token != null && token.isNotEmpty) {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return request;
      })
      ..addResponseModifier((request, response) {
        Logger().info(
          'HTTP ${response.statusCode} ${request.url}',
          tag: 'http',
        );
        return response;
      });
  }

  String? get _token {
    if (Get.isRegistered<OauthService>()) {
      return Get.find<OauthService>().oauth.value.accessToken;
    }
    return null;
  }

  /// GET 请求（支持缓存）
  Future<ApiResponse<T>> getJson<T>(
    String path, {
    Map<String, dynamic>? query,
    T Function(dynamic data)? decoder,
    bool useCache = false,
    Duration? cacheDuration,
  }) async {
    final cacheKey = _buildCacheKey(path, query);

    if (useCache) {
      final cached = ApiCache.get(cacheKey);
      if (cached != null) {
        return ApiResponse<T>(
          success: true,
          data: decoder != null ? decoder(cached) : cached as T?,
          message: '',
          statusCode: 200,
        );
      }
    }

    final response = await _retryRequest(
      () => get(path, query: query),
    );

    final result = _wrapResponse(response, decoder);

    if (useCache && result.success && result.data != null) {
      ApiCache.set(cacheKey, response.body, duration: cacheDuration);
    }

    return result;
  }

  /// POST 请求（支持重试）
  Future<ApiResponse<T>> postJson<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? query,
    T Function(dynamic data)? decoder,
  }) async {
    final response = await _retryRequest(
      () => post(path, body, query: query),
    );
    return _wrapResponse(response, decoder);
  }

  /// 请求重试逻辑
  Future<Response> _retryRequest(
    Future<Response> Function() request, {
    int retries = 0,
  }) async {
    try {
      final response = await request();

      if (_shouldRetry(response) && retries < _maxRetries) {
        await Future.delayed(Duration(seconds: retries + 1));
        return _retryRequest(request, retries: retries + 1);
      }

      return response;
    } on SocketException {
      if (retries < _maxRetries) {
        await Future.delayed(Duration(seconds: retries + 1));
        return _retryRequest(request, retries: retries + 1);
      }
      rethrow;
    } catch (e) {
      if (retries < _maxRetries && _isRetryableError(e)) {
        await Future.delayed(Duration(seconds: retries + 1));
        return _retryRequest(request, retries: retries + 1);
      }
      rethrow;
    }
  }

  bool _shouldRetry(Response response) {
    final code = response.statusCode ?? 0;
    return code == 408 || code == 429 || code >= 500;
  }

  bool _isRetryableError(dynamic error) {
    return error is SocketException ||
        error is TimeoutException ||
        error is HttpException;
  }

  ApiResponse<T> _wrapResponse<T>(
    Response<dynamic> res,
    T Function(dynamic data)? decoder,
  ) {
    final statusCode = res.statusCode ?? 0;
    final bool success = statusCode >= 200 && statusCode < 300;
    final body = res.body;

    String message = '';
    if (!success) {
      message = _getErrorMessage(statusCode, body);
    }

    final T? parsed = decoder != null ? decoder(body) : body as T?;
    return ApiResponse<T>(
      success: success,
      data: parsed,
      message: message,
      statusCode: statusCode,
    );
  }

  String _getErrorMessage(int statusCode, dynamic body) {
    if (body is Map && body['message'] != null) {
      return body['message'].toString();
    }

    switch (statusCode) {
      case 400:
        return '请求参数错误';
      case 401:
        return '未授权，请重新登录';
      case 403:
        return '无权限访问';
      case 404:
        return '请求的资源不存在';
      case 408:
        return '请求超时';
      case 429:
        return '请求过于频繁';
      case 500:
        return '服务器内部错误';
      case 502:
        return '网关错误';
      case 503:
        return '服务暂时不可用';
      default:
        return '请求失败 ($statusCode)';
    }
  }

  String _buildCacheKey(String path, Map<String, dynamic>? query) {
    if (query == null || query.isEmpty) return path;
    final queryStr = query.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$path?$queryStr';
  }
}
