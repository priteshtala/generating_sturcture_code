import 'exception.dart';

sealed class DataEvent<T> {
  const DataEvent();
}

final class SuccessEvent<T> extends DataEvent<T> {
  final T data;
  final int? statusCode;
  final bool isCache;

  const SuccessEvent(this.data, {this.isCache = false, this.statusCode});

  @override
  String toString() => 'SuccessEvent{data: $data, isCache: $isCache, statusCode: $statusCode}';
}

final class FailureEvent<T> extends DataEvent<T> {
  final ApiException exception;

  const FailureEvent(this.exception);

  @override
  String toString() => 'FailureEvent{exception: $exception}';
}

final class LoadingEvent<T> extends DataEvent<T> {
  final bool isLoading;

  const LoadingEvent([this.isLoading = false]);

  @override
  String toString() => 'LoadingEvent{isLoading: $isLoading}';
}
