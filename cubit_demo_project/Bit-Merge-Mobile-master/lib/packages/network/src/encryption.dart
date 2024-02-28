import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';

class Encryption {
  final IV _iv;
  final Encrypter _encrypter;
  final Hmac _hMac;

  const Encryption._private(this._iv, this._encrypter, this._hMac);

  factory Encryption.fromUtf8({required String key, required String iv}) {
    var encryptionKey = Key.fromUtf8(key);
    return Encryption._private(
      IV.fromUtf8(iv),
      Encrypter(AES(encryptionKey, mode: AESMode.cbc)),
      Hmac(sha256, encryptionKey.bytes),
    );
  }

  factory Encryption.fromBase64({required String key, required String iv}) {
    var encryptionKey = Key.fromBase64(key);
    return Encryption._private(
      IV.fromBase64(iv),
      Encrypter(AES(encryptionKey, mode: AESMode.cbc)),
      Hmac(sha256, encryptionKey.bytes),
    );
  }

  CipherData encrypt(String plainText) {
    try {
      var encryptedValue = _encrypter.encrypt(plainText, iv: _iv).base64.replaceAll("\n", "");
      var mac = _createMac(encryptedValue);
      return CipherData(mac: mac.toString(), value: encryptedValue);
    } catch (e) {
      rethrow;
    }
  }

  String decrypt(CipherData data) {
    var valueMac = _createMac(data.value);
    if (valueMac.toString() == data.mac) {
      return _encrypter.decrypt64(data.value, iv: _iv);
    } else {
      throw Exception('Invalid mac!');
    }
  }

  String _createMac(String value) {
    return _hMac.convert(utf8.encode(_iv.base64 + value)).toString();
  }
}

class DecryptionException implements Exception {
  DecryptionException();

  @override
  String toString() => "DecryptionException(message: Unable to decrypt provided data!)";
}

class CipherData extends Equatable {
  final String mac;
  final String value;

  const CipherData({required this.mac, required this.value});

  @override
  List<Object?> get props => [mac, value];

  factory CipherData.fromJson(Map<String, dynamic> json) {
    return CipherData(
      mac: json['mac'] as String,
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mac': mac,
      'value': value,
    };
  }
}
