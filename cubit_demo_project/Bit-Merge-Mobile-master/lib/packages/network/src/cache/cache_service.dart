import 'dart:async';

import 'cached_response.dart';

abstract base class CacheService {
  FutureOr<void> init();

  FutureOr<CachedResponse?> get(String key);

  FutureOr<void> set(String key, CachedResponse data);

  FutureOr<void> remove(String key);

  FutureOr<void> clear();

  FutureOr<void> close();
}
