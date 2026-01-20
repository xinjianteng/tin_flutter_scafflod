/// 使用方法：ValidateUtil.validateAccount(account);
import 'package:tin_flutter_scafflod/values/constant.dart';

/// 校验工具：集中管理表单校验规则。
class ValidateUtil {
  static bool isPhone(String value) => AppConstants.phoneReg.hasMatch(value);

  static bool isEmail(String value) => AppConstants.emailReg.hasMatch(value);

  static String? validateNotEmpty(String value, {String? message}) {
    if (value.trim().isEmpty) {
      return message ?? '请输入内容';
    }
    return null;
  }

  static String? validatePhone(String value) {
    final text = value.trim();
    if (text.isEmpty) return '请输入手机号';
    if (!isPhone(text)) return '手机号格式不正确';
    return null;
  }

  static String? validateEmail(String value) {
    final text = value.trim();
    if (text.isEmpty) return '请输入邮箱';
    if (!isEmail(text)) return '邮箱格式不正确';
    return null;
  }

  static String? validateAccount(String value) {
    final text = value.trim();
    if (text.isEmpty) return '请输入手机号或邮箱';
    if (!isPhone(text) && !isEmail(text)) {
      return '手机号或邮箱格式不正确';
    }
    return null;
  }

  static String? validatePassword(
    String value, {
    int min = 6,
    int max = 20,
  }) {
    final text = value.trim();
    if (text.isEmpty) return '请输入密码';
    if (text.length < min) return '密码长度不少于 $min 位';
    if (text.length > max) return '密码长度不超过 $max 位';
    return null;
  }

  static String? validateSmsCode(
    String value, {
    int min = 4,
    int max = 6,
  }) {
    final text = value.trim();
    if (text.isEmpty) return '请输入验证码';
    if (text.length < min || text.length > max) {
      return '验证码长度应为 $min-$max 位';
    }
    return null;
  }
}
