/// 使用方法：AuthRemoteDataSource(apiClient: Get.find<ApiClient>());
import 'package:tin_flutter_scafflod/api/api_client.dart';
import 'package:tin_flutter_scafflod/models/oauth.dart';

/// 认证远端数据源：负责与服务端交互。
class AuthRemoteDataSource {
  AuthRemoteDataSource({required this.apiClient});

  final ApiClient apiClient;

  Future<ExampleOauth> loginWithPassword({
    required String account,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return ExampleOauth(
      accessToken: 'mock-token',
      userId: '10001',
      userName: account,
    );
  }

  Future<bool> requestSmsCode({required String phone}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return phone.isNotEmpty;
  }

  Future<ExampleOauth> loginWithSms({
    required String phone,
    required String code,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return ExampleOauth(
      accessToken: 'mock-token',
      userId: '10001',
      userName: phone,
    );
  }
}
