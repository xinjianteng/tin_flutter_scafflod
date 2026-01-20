/// 网络缓存管理
class ApiCache {
  static final Map<String, _CacheEntry> _cache = {};
  static const Duration _defaultDuration = Duration(minutes: 5);

  static void set(String key, dynamic data, {Duration? duration}) {
    _cache[key] = _CacheEntry(
      data: data,
      expireAt: DateTime.now().add(duration ?? _defaultDuration),
    );
  }

  static dynamic get(String key) {
    final entry = _cache[key];
    if (entry == null || entry.isExpired) {
      _cache.remove(key);
      return null;
    }
    return entry.data;
  }

  static void clear() => _cache.clear();

  static void remove(String key) => _cache.remove(key);
}

class _CacheEntry {
  final dynamic data;
  final DateTime expireAt;

  _CacheEntry({required this.data, required this.expireAt});

  bool get isExpired => DateTime.now().isAfter(expireAt);
}
