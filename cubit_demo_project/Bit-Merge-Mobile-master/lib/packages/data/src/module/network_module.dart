import 'dart:io';

import 'package:bit_merge_mobile/packages/core/core.dart' as core;
import 'package:bit_merge_mobile/packages/data/data.dart';
import 'package:bit_merge_mobile/packages/network/network.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  @preResolve
  Future<CacheService> getCacheService() async {
    var path = await core.cacheDirectory();
    var service = StorageCacheService(storagePath: path);
    await service.init();
    return service;
  }

  @singleton
  Dio getDioInstance({required AppPreference pref, required core.Environment environment}) {
    void onNewTokenData(TokenData data) {
      pref.userToken = data.accessToken;
    }

    var options = BaseOptions(
      baseUrl: environment.baseAPI,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      headers: {
        HttpHeaders.acceptHeader: Headers.jsonContentType,
        HttpHeaders.contentTypeHeader: Headers.jsonContentType,
      },
    );

    return Dio(options)
      ..interceptors.addAll([
        AuthInterceptor(
          getAccessToken: () => pref.userToken,
          onNewTokenData: onNewTokenData,
        ),
        if (environment.isLogEnabled) LoggingInterceptor(),
        /*EncryptionInterceptor(
          encryptionKey: environment.encryptionKey,
          encryptionIv: environment.encryptionIv,
          decryptionKey: environment.decryptionKey,
          decryptionIv: environment.decryptionIv,
          logEnabled: environment.isLogEnabled,
        ),*/
        /* RefreshTokenInterceptor(
          refreshTokenUrl: "${environment.baseApi}user/refresh/token",
          getRefreshToken: () => pref.refreshToken,
          onNewTokenData: onNewTokenData,
          logEnabled: environment.isLogEnabled,
        ),*/
      ]);
  }
}
