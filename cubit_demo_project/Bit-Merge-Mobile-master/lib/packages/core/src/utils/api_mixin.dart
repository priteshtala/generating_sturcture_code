import 'dart:async';
import 'dart:math';

import 'package:bit_merge_mobile/packages/components/components.dart';
import 'package:bit_merge_mobile/packages/network/network.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

typedef ResultCallback<T> = void Function(T data);
typedef LoadingCallback = void Function(bool isLoading);
typedef ApiExceptionCallback = void Function(ApiException exception);

mixin ApiMixin<S extends Object?> on BlocBase<S> {
  int _loaderCount = 0;
  late final _navigator = Navigator.of(context);
  Route? _dialogRoute;

  BuildContext get context;

  @override
  Future<void> close() {
    if (_loaderCount > 0) handleLoading(false);
    return super.close();
  }

  @mustCallSuper
  @protected
  StreamSubscription<DataEvent<T>> processData<T>(
    Stream<DataEvent<T>> stream, {
    bool handleLoading = true,
    bool ignoreCache = false,
    required ResultCallback<T>? onSuccess,
    LoadingCallback? onLoading,
    ApiExceptionCallback? onFailure,
  }) {
    return stream.listen((event) {
      switch (event) {
        case LoadingEvent<T>():
          if (handleLoading) (onLoading ?? _handleLoader)(event.isLoading);
          break;
        case SuccessEvent<T>():
          if (event.isCache && ignoreCache) break;
          onSuccess?.call(event.data);
          break;
        case FailureEvent<T>():
          (onFailure ?? addError)(event.exception);
      }
    });
  }

  /// handles show/dismiss of loading dialog
  void _handleLoader(bool isLoading) {
    if (isLoading) {
      if (_loaderCount == 0) handleLoading(isLoading);
      _loaderCount++;
    } else {
      _loaderCount = max(0, _loaderCount - 1);
      if (_loaderCount == 0) handleLoading(isLoading);
    }
  }

  void handleLoading(bool isLoading) {
    if (isLoading) {
      _startLoading();
    } else {
      _stopLoading();
    }
  }

  Route _buildDialogRoute(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final CapturedThemes themes = InheritedTheme.capture(from: context, to: _navigator.context);
    return DialogRoute(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      settings: const RouteSettings(name: "/loading_dialog"),
      themes: themes,
      builder: (context) => const LoadingDialog(),
    );
  }

  void _startLoading() {
    if (_dialogRoute != null) return;
    _dialogRoute = _buildDialogRoute(context);
    _navigator.push(_dialogRoute!);
  }

  void _stopLoading() {
    if (_dialogRoute != null) _navigator.removeRoute(_dialogRoute!);
    _dialogRoute = null;
  }
}
