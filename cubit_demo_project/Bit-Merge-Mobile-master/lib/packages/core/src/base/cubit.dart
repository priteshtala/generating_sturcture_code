import 'dart:async';

import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bit_merge_mobile/packages/network/network.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class BaseCubit<S extends Object?> extends Cubit<S> with StreamSubscriptionMixin, ListMixin, ApiMixin {
  @override
  final BuildContext context;

  BaseCubit(this.context, super.initialState) {
    Timer.run(onCreate);
  }

  @protected
  @mustCallSuper
  void onCreate() {}

  @override
  StreamSubscription<DataEvent<T>> processData<T>(
    Stream<DataEvent<T>> stream, {
    bool handleLoading = true,
    bool ignoreCache = false,
    required ResultCallback<T>? onSuccess,
    LoadingCallback? onLoading,
    ApiExceptionCallback? onFailure,
  }) {
    final subscription = super.processData(
      stream,
      handleLoading: handleLoading,
      ignoreCache: ignoreCache,
      onLoading: onLoading,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );
    listSubscription.add(subscription);
    return subscription;
  }
}

abstract class DataCubit<S extends DataState> extends BaseCubit<S> {
  DataCubit(super.context, super.initialState);

  @mustCallSuper
  Future<void> onRefresh() async {
    if (state.isLoading) return;
    return fetchData();
  }

  Future<void> fetchData();
}

abstract class ListCubit<S extends ListState> extends BaseCubit<S> {
  ListCubit(super.context, super.initialState);

  Future<void> fetchList();
}

abstract class PaginatedListCubit<S extends PaginatedListState<T>, T extends Object?> extends ListCubit<S> {
  PaginatedListCubit(super.context, super.initialState);

  @mustCallSuper
  bool onScrollNotification(UserScrollNotification notification) {
    if (notification.metrics.pixels >= notification.metrics.maxScrollExtent) onScrollToEnd();
    return false;
  }

  @mustCallSuper
  Future<void> onScrollToEnd() async {
    if (state.isLoading || state.reachAtEnd) return;
    emit(state.copyWith(isLoading: true) as S);
    onLoadMore();
  }

  @mustCallSuper
  Future<void> onRefresh() async {
    if (state.isLoading) return;
    emit(state.copyWith(reachAtEnd: false, list: <T>[]) as S);
    return fetchList();
  }

  Future<void> onLoadMore() => fetchList();
}
