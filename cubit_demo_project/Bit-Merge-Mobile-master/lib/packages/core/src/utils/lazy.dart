import 'dart:async';

typedef LazyFactory<T> = T Function();
typedef LazyFutureFactory<T> = Future<T> Function();

class Lazy<T> {
  final LazyFactory<T> _factory;
  T? _data;

  Lazy(this._factory);

  T call() => _data ??= _factory();

  T get value => call();

  bool get isInitialized => _data != null;
}

class LazyFuture<T> {
  final LazyFutureFactory<T> _factory;
  final Completer<T> _completer = Completer();
  bool _isCompleted = false;

  LazyFuture(this._factory);

  Future<T> call() {
    if (!_isCompleted) {
      _completer.complete(_factory());
      _isCompleted = true;
    }
    return _completer.future;
  }

  Future<T> get value => call();

  bool get isInitialized => _isCompleted;
}
