import 'dart:async';

import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bloc/bloc.dart';

mixin StreamSubscriptionMixin<S extends Object?> on BlocBase<S> {
  final Lazy<List<StreamSubscription>> _listSubscription = Lazy(() => []);

  List<StreamSubscription> get listSubscription => _listSubscription();

  @override
  Future<void> close() {
    return Future.wait([
      if (_listSubscription.isInitialized) ..._listSubscription().map((subscription) => subscription.cancel()),
      super.close(),
    ]);
  }
}
