/// 错误消息映射
class ErrorMessages {
  // 网络错误
  static const String networkError = '网络连接失败';
  static const String timeoutError = '请求超时';
  static const String noInternetError = '无网络连接';

  // 服务器错误
  static const String serverError = '服务器错误';
  static const String notFoundError = '资源不存在';
  static const String unauthorizedError = '未授权访问';
  static const String forbiddenError = '访问被拒绝';

  // 验证错误
  static const String invalidPhoneError = '手机号格式不正确';
  static const String invalidEmailError = '邮箱格式不正确';
  static const String invalidPasswordError = '密码格式不正确';
  static const String emptyFieldError = '此字段不能为空';

  // 业务错误
  static const String loginFailedError = '登录失败';
  static const String registerFailedError = '注册失败';
  static const String uploadFailedError = '上传失败';
  static const String downloadFailedError = '下载失败';

  // 权限错误
  static const String cameraPermissionError = '需要相机权限';
  static const String storagePermissionError = '需要存储权限';
  static const String locationPermissionError = '需要定位权限';

  /// 根据错误码获取错误消息
  static String getMessageByCode(String? code) {
    switch (code) {
      case 'NETWORK_ERROR':
        return networkError;
      case 'TIMEOUT_ERROR':
        return timeoutError;
      case 'SERVER_ERROR':
        return serverError;
      case '404':
        return notFoundError;
      case '401':
        return unauthorizedError;
      case '403':
        return forbiddenError;
      default:
        return '操作失败，请重试';
    }
  }
}
