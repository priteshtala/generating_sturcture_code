import 'dart:async';

import 'package:hive/hive.dart';

import 'cache_service.dart';
import 'cached_response.dart';

final class StorageCacheService extends CacheService {
  StorageCacheService({
    this.storageKey,
    this.storagePath,
  });

  final String? storageKey;
  final String? storagePath;
  late final LazyBox<Map<dynamic, dynamic>> _hiveBox;

  @override
  FutureOr<void> init() async {
    _hiveBox = await Hive.openLazyBox(storageKey ?? 'storage_cache_service', path: storagePath);
  }

  @override
  FutureOr<CachedResponse?> get(String key) {
    return _hiveBox.get(key).then((value) {
      return value != null ? CachedResponse.fromJson(value.map((key, value) => MapEntry(key.toString(), value))) : null;
    });
  }

  @override
  FutureOr<void> set(String key, CachedResponse data) {
    return _hiveBox.put(key, data.toJson());
  }

  @override
  FutureOr<void> remove(String key) {
    return _hiveBox.delete(key);
  }

  @override
  FutureOr<void> clear() async {
    await _hiveBox.clear();
  }

  @override
  FutureOr<void> close() {
    return _hiveBox.close();
  }
}
