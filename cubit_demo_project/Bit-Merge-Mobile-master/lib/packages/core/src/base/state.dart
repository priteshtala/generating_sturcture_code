import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseLoadingState {
  final bool isLoading;

  const BaseLoadingState({
    required this.isLoading,
  });
}

abstract class LoadingState extends Equatable implements BaseLoadingState {
  @override
  final bool isLoading;

  const LoadingState({
    this.isLoading = false,
  });

  @mustCallSuper
  @override
  List<Object?> get props => [isLoading];

  LoadingState copyWith({bool? isLoading});
}

class DataState<T> extends LoadingState {
  final T? data;

  const DataState({
    this.data,
    super.isLoading,
  });

  bool get hasData => data != null;

  @override
  List<Object?> get props => super.props..add(data);

  @override
  DataState<T> copyWith({T? data, bool? isLoading}) {
    return DataState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ListState<T> extends LoadingState {
  final List<T> list;

  const ListState({
    this.list = const [],
    super.isLoading,
  });

  bool get hasData => list.isNotEmpty;

  bool get showLoading => list.isEmpty && isLoading;

  T operator [](int index) => list[index];

  @override
  List<Object?> get props => super.props..add(list);

  @override
  ListState<T> copyWith({bool? isLoading, List<T>? list}) {
    return ListState(
      list: list ?? this.list,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SelectionListState<T, S> extends ListState<T> {
  final S? selected;

  const SelectionListState({
    super.list,
    super.isLoading,
    this.selected,
  });

  @override
  List<Object?> get props => super.props..add(selected);

  @override
  SelectionListState<T, S> copyWith({bool? isLoading, List<T>? list, S? selected}) {
    return SelectionListState(
      list: list ?? this.list,
      isLoading: isLoading ?? this.isLoading,
      selected: selected ?? this.selected,
    );
  }
}

class PaginatedListState<T> extends ListState<T> {
  final bool reachAtEnd;

  const PaginatedListState({
    this.reachAtEnd = false,
    super.list,
    super.isLoading,
  });

  @override
  List<Object?> get props => super.props..add(reachAtEnd);

  @override
  PaginatedListState<T> copyWith({
    bool? isLoading,
    bool? reachAtEnd,
    List<T>? list,
  }) {
    return PaginatedListState(
      list: list ?? this.list,
      isLoading: isLoading ?? this.isLoading,
      reachAtEnd: reachAtEnd ?? this.reachAtEnd,
    );
  }

  PaginatedListState<T> appendList({
    bool? isLoading,
    bool? reachAtEnd,
    required List<T> list,
  }) {
    return PaginatedListState(
      list: List.from(this.list)..addAll(list),
      isLoading: isLoading ?? this.isLoading,
      reachAtEnd: reachAtEnd ?? this.reachAtEnd,
    );
  }
}
