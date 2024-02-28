import 'dart:io';

import 'package:dio/dio.dart';

import '../utils/token_parsing_helper.dart';
import 'interceptors.dart';

class AuthInterceptor extends Interceptor {
  final TokenDataCallback onNewTokenData;
  final GetTokenCallback getAccessToken;

  AuthInterceptor({required this.onNewTokenData, required this.getAccessToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = getAccessToken();
    if (accessToken?.isNotEmpty ?? false) {
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final tokenData = parseTokenData(response);
    if (tokenData != null) onNewTokenData(tokenData);
    super.onResponse(response, handler);
  }
}
