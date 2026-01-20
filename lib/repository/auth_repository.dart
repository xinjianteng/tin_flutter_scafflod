/// 使用方法：AuthRepository(remote: Get.find<AuthRemoteDataSource>());
import 'package:tin_flutter_scafflod/datasource/auth_remote_data_source.dart';
import 'package:tin_flutter_scafflod/models/oauth.dart';

/// 认证仓库：封装领域逻辑与数据源调用。
class AuthRepository {
  AuthRepository({required this.remote});

  final AuthRemoteDataSource remote;

  Future<ExampleOauth> loginWithPassword({
    required String account,
    required String password,
  }) {
    return remote.loginWithPassword(
      account: account,
      password: password,
    );
  }

  Future<bool> requestSmsCode({required String phone}) {
    return remote.requestSmsCode(phone: phone);
  }

  Future<ExampleOauth> loginWithSms({
    required String phone,
    required String code,
  }) {
    return remote.loginWithSms(phone: phone, code: code);
  }
}
