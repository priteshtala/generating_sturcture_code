import 'package:dio/dio.dart';

import '../token_data.dart';

TokenData? parseTokenData(Response response) {
  String refreshToken = "";
  String accessToken = "";

  final cookieHeaders = response.headers["set-cookie"] ?? [];
  for (var cookieHeader in cookieHeaders) {
    final cookies = cookieHeader.split(";");
    for (var cookie in cookies) {
      if (cookie.contains("=")) {
        var [key, value] = cookie.split("=");
        switch (key.trim()) {
          case "accessToken":
            accessToken = value;
            break;
          case "refreshToken":
            refreshToken = value;
            break;
        }
      }
    }
  }

  if (refreshToken.isNotEmpty && accessToken.isNotEmpty) {
    return TokenData(accessToken: accessToken, refreshToken: refreshToken);
  }
  return null;
}
