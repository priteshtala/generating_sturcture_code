import 'package:dio/dio.dart';

import '../utils/log_mixin.dart';

const _titleSeparator = "══════════════════════════════════════════════════";

class LoggingInterceptor extends InterceptorsWrapper with LogMixin {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printRequest("$_titleSeparator Request Options $_titleSeparator");
    printRequest("[${options.method.toUpperCase()}] ${options.uri}");
    if (options.queryParameters.isNotEmpty) printRequest(options.queryParameters, "QueryParameters");
    printRequest(options.headers, "Headers");
    if (options.data is Map || options.data is Iterable) printRequest(options.data, "Data");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printResponse("$_titleSeparator Response $_titleSeparator");
    printResponse(
        "[${response.requestOptions.method.toUpperCase()}] [${response.statusCode}] ${response.requestOptions.uri}");
    if (response.data is Map || response.data is List) printResponse(response.data, "Data");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    printError("$_titleSeparator DioError $_titleSeparator");
    printError("[${err.requestOptions.method.toUpperCase()}] [${err.response?.statusCode}] ${err.requestOptions.uri}");
    printError("[${err.type}] ${err.message}");
    if (err.response?.data is Map) printError(err.response?.data, "Data");
    super.onError(err, handler);
  }
}
