import 'dart:convert';

import 'package:dio/dio.dart';

import '../encryption.dart';
import '../utils/log_mixin.dart';

class EncryptionInterceptor extends InterceptorsWrapper with LogMixin {
  final Encryption _encryption;
  final Encryption _decryption;
  final bool logEnabled;

  EncryptionInterceptor({
    required String encryptionKey,
    required String encryptionIv,
    required String decryptionKey,
    required String decryptionIv,
    this.logEnabled = false,
  })  : _encryption = Encryption.fromUtf8(key: encryptionKey, iv: encryptionIv),
        _decryption = Encryption.fromUtf8(key: decryptionKey, iv: decryptionIv);

  EncryptionInterceptor.fromBase64({
    required String encryptionKey,
    required String encryptionIv,
    required String decryptionKey,
    required String decryptionIv,
    this.logEnabled = false,
  })  : _encryption = Encryption.fromBase64(key: encryptionKey, iv: encryptionIv),
        _decryption = Encryption.fromBase64(key: decryptionKey, iv: decryptionIv);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if ((options.data is Map<String, dynamic> && options.data.isNotEmpty) ||
        (options.data is Iterable && options.data.isNotEmpty)) {
      var cipherData = _encryption.encrypt(jsonEncode(options.data));
      options.data = cipherData.toJson();
      if (logEnabled) printRequest(options.data, "Encrypted Data");
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final responseData = response.data;
    if (responseData is Map<String, dynamic>) {
      try {
        var decrypted = _decryption.decrypt(CipherData.fromJson(responseData));
        var decryptedData = decrypted.isEmpty ? "" : jsonDecode(decrypted);
        response.data = decryptedData;
        if (logEnabled) printResponse(response.data, "Decrypted Data");
      } catch (error) {
        return handler.reject(DioException(
          type: DioExceptionType.unknown,
          requestOptions: response.requestOptions,
          error: DecryptionException(),
        ));
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var requestData = err.requestOptions.data;
    if (requestData is Map<String, dynamic> && requestData.isNotEmpty) {
      var decrypted = _encryption.decrypt(CipherData.fromJson(requestData));
      err.requestOptions.data = jsonDecode(decrypted);
    }
    super.onError(err, handler);
  }
}
