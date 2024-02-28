import 'dart:async';

import 'cache_service.dart';
import 'cached_response.dart';

final class MemoryCacheService extends CacheService {
  MemoryCacheService();

  final Map<String, dynamic> _cache = {};

  @override
  FutureOr<void> init() {}

  @override
  FutureOr<CachedResponse?> get(String key) {
    final value = _cache[key];
    return value != null ? CachedResponse.fromJson(value) : null;
  }

  @override
  FutureOr<void> set(String key, CachedResponse data) {
    _cache[key] = data.toJson();
  }

  @override
  FutureOr<void> remove(String key) {
    _cache.remove(key);
  }

  @override
  FutureOr<void> clear() {
    _cache.clear();
  }

  @override
  FutureOr<void> close() {
    _cache.clear();
  }
}
