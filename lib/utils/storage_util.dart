/// 使用方法：await StorageUtil.setSecureString(StorageUtil.keyOauth, json);
import 'package:tin_flutter_scafflod/utils/encrypt_util.dart';
import 'package:tin_flutter_scafflod/utils/prefs_util.dart';
import 'package:tin_flutter_scafflod/values/constant.dart';

/// 存储工具：包装 SharedPreferences，提供加密存取能力。
class StorageUtil {
  StorageUtil._();

  static const String keyOauth = 'oauth';

  static Future<void> _ensureInit() => PrefsUtil.ensureInitialized();

  static Future<bool> setString(String key, String value) async {
    await _ensureInit();
    return PrefsUtil().setString(key, value);
  }

  static Future<String?> getString(String key) async {
    await _ensureInit();
    return PrefsUtil().getString(key);
  }

  static Future<bool> remove(String key) async {
    await _ensureInit();
    return PrefsUtil().remove(key);
  }

  static Future<bool> setSecureString(
    String key,
    String value, {
    String? aesKey,
    String? aesIv,
  }) async {
    final encrypted = EncryptUtils.encryptAES(
      value,
      aesKey ?? AppConstants.aesKey,
      aesIv ?? AppConstants.aesIv,
    );
    return setString(key, encrypted);
  }

  static Future<String?> getSecureString(
    String key, {
    String? aesKey,
    String? aesIv,
  }) async {
    final encrypted = await getString(key);
    if (encrypted == null || encrypted.isEmpty) return null;
    try {
      return EncryptUtils.decryptAES(
        encrypted,
        aesKey ?? AppConstants.aesKey,
        aesIv ?? AppConstants.aesIv,
      );
    } catch (_) {
      return null;
    }
  }
}
