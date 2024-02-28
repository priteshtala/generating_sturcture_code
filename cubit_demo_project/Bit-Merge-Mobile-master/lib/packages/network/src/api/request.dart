import 'dart:async';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import 'response.dart';
import 'type.dart';

typedef ResponseParser<T> = FutureOr<T> Function(dynamic responseData);

T _defaultResponseParser<T>(dynamic responseData) => responseData as T;

base class ApiRequest<T extends Object?> {
  final RequestType requestType;
  final String path;
  Map<String, dynamic>? headers;
  Map<String, dynamic>? queryParams;
  Map<String, dynamic>? pathParams;
  Object? data;
  ResponseParser<T> responseParser;

  ApiRequest(
    this.requestType,
    this.path, {
    this.headers,
    this.queryParams,
    this.pathParams,
    this.data,
    ResponseParser<T>? responseParser,
  }) : responseParser = responseParser ?? _defaultResponseParser;

  static const _uuid = Uuid();

  String get _path {
    String path = this.path;
    final pathParams = this.pathParams;
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        path = path.replaceAll("{$key}", value.toString());
      });
    }
    return path;
  }

  Map<String, dynamic> get _queryParams {
    return (this.queryParams ?? {}).map((key, value) {
      return MapEntry(key, value is List ? value.map((e) => e.toString()).toList() : value.toString());
    });
  }

  String get cacheKey {
    return _uuid.v5(
      Uuid.NAMESPACE_URL,
      Uri(path: _path, queryParameters: _queryParams).toString(),
    );
  }

  Future<ApiResponse<T>> fetch(
    Dio dio, {
    String? baseUrl,
    CancelToken? cancelToken,
    ProgressCallback? receiveProgress,
    ProgressCallback? sendProgress,
  }) async {
    final RequestOptions options = RequestOptions(
      method: requestType.name,
      path: _path,
      baseUrl: baseUrl ?? dio.options.baseUrl,
      queryParameters: {
        ..._queryParams,
        ...dio.options.queryParameters,
      },
      data: data,
      headers: {
        ...?headers,
        ...dio.options.headers,
      },
      cancelToken: cancelToken,
      onSendProgress: sendProgress,
      onReceiveProgress: receiveProgress,
    );
    if (T != dynamic && !(options.responseType == ResponseType.bytes || options.responseType == ResponseType.stream)) {
      options.responseType = ResponseType.json;
    }
    final response = await dio.fetch(options);
    return ApiResponse(
      statusCode: response.statusCode,
      response: response,
      data: await responseParser.call(response.data),
    );
  }
}
