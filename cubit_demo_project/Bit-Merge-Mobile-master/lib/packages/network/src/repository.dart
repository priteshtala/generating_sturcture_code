import 'dart:async';
import 'dart:io' as io;

import 'package:dio/dio.dart';

import 'api/request.dart';
import 'api/response.dart';
import 'api/type.dart';
import 'cache/cache_service.dart';
import 'cache/cached_response.dart';
import 'event.dart';
import 'exception.dart';
import 'utils/log_mixin.dart';

abstract class BaseRepository with LogMixin {
  final Dio dio;
  final CacheService? cacheService;
  final Duration cacheValidity = const Duration(days: 7);
  final String? baseUrl;

  BaseRepository({
    required this.dio,
    this.cacheService,
    this.baseUrl,
  });

  Stream<DataEvent<T>> processApi<T>(ApiRequest<T> request, {bool fromCache = true}) async* {
    yield const LoadingEvent(true);
    if (cacheService != null && fromCache) {
      final cachedResponse = await _getResponseFromCache(request);
      if (cachedResponse != null) {
        yield const LoadingEvent(false);
        yield SuccessEvent(cachedResponse.data, statusCode: cachedResponse.statusCode, isCache: true);
      }
    }
    yield* _getResponseFromNetwork(request);
  }

  Future<({T data, int? statusCode})?> _getResponseFromCache<T>(ApiRequest<T> request) async {
    if (request.requestType != RequestType.get) return null;
    try {
      var cache = await cacheService?.get(request.cacheKey);
      if (cache != null) {
        if (!cache.createAt.isAfter(DateTime.now().subtract(cacheValidity))) {
          cacheService?.remove(request.cacheKey);
          return null;
        }
        var data = await request.responseParser.call(cache.data);
        return (data: data, statusCode: cache.statusCode);
      }
    } catch (error, stackTrace) {
      printError(error);
      printError(stackTrace);
    }
    return null;
  }

  Future<T> processApiRequest<T>(ApiRequest<T> request, {bool fromCache = true}) async {
    try {
      final result = await request.fetch(dio);
      _saveCacheResponse(request, result);
      return result.data;
    } catch (error, stacktrace) {
      switch (error) {
        case DioException():
          if (error.error is TokenExpiredException) {
            return processApiRequest(request);
          } else if (error.error is io.SocketException || error.error is io.HttpException) {
            _handleInternetConnectionException(request, error);
          } else {
            var apiException = handleDioException(error);
            if (apiException != null) throw apiException;
          }
          break;
        case io.SocketException() || io.HttpException():
          _handleInternetConnectionException(request, error);
        default:
          printError(error);
          printError(stacktrace);
      }
      rethrow;
    }
  }

  Future<T?> _handleInternetConnectionException<T>(ApiRequest<T> request, Object error) async {
    final cachedResponse = await _getResponseFromCache(request);
    if (cachedResponse != null) return cachedResponse.data;
    throw InternetConnectionException(message: error.toString());
  }

  Stream<DataEvent<T>> _getResponseFromNetwork<T>(
    ApiRequest<T> request, {
    CancelToken? cancelToken,
    ProgressCallback? receiveProgress,
    ProgressCallback? sendProgress,
  }) async* {
    try {
      var response = await request.fetch(
        dio,
        baseUrl: baseUrl,
        cancelToken: cancelToken,
        receiveProgress: receiveProgress,
        sendProgress: sendProgress,
      );
      yield const LoadingEvent(false);
      yield SuccessEvent(response.data, statusCode: response.statusCode);
      _saveCacheResponse(request, response);
    } catch (error, stacktrace) {
      yield const LoadingEvent(false);
      switch (error) {
        case DioException():
          if (error.error is TokenExpiredException) {
            yield* processApi(request);
          } else if (error.error is io.SocketException || error.error is io.HttpException) {
            yield FailureEvent(InternetConnectionException(message: error.error.toString()));
          } else {
            var apiException = handleDioException(error);
            if (apiException != null) yield FailureEvent(apiException);
          }
          break;
        case io.SocketException() || io.HttpException():
          yield FailureEvent(InternetConnectionException(message: error.toString()));
          break;
        default:
          printError(error);
          printError(stacktrace);
      }
    }
  }

  Future<void> _saveCacheResponse(ApiRequest request, ApiResponse response) async {
    if (request.requestType != RequestType.get) return;
    cacheService?.set(
      request.cacheKey,
      CachedResponse(data: response.response.data, statusCode: response.statusCode, createAt: DateTime.now()),
    );
  }

  ApiException? handleDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.badResponse:
        if (dioException.response?.statusCode == io.HttpStatus.unauthorized) {
          return const UnauthorizedException();
        } else if (dioException.response?.data != null) {
          return _handleResponseError(dioException);
        }
        break;
      case DioExceptionType.unknown:
        throw dioException;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.connectionError:
        break;
    }
    return null;
  }

  ApiResponseException _handleResponseError(DioException dioException) {
    String? message;
    Map<String, dynamic>? errors;
    final responseData = dioException.response?.data;
    if (responseData is Map<String, dynamic>) {
      if (responseData['message'] is String) message = responseData['message'];
      if (responseData['errors'] is Map<String, dynamic>) errors = responseData['errors'];
    }
    return ApiResponseException(statusCode: dioException.response?.statusCode ?? -1, message: message, errors: errors);
  }
}
