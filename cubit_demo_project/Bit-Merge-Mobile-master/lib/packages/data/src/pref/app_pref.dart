import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  final SharedPreferences _preference;

  AppPreference(this._preference);

  Future<bool> clear() {
    var showIntro = this.showIntro;
    var locale = this.locale;
    return _preference.clear().whenComplete(() {
      this.showIntro = showIntro;
      this.locale = locale;
    });
  }

  ThemeMode get themeMode => ThemeMode.values.byName(_preference.getString("themeMode") ?? "dark");

  set themeMode(ThemeMode value) => _preference.setString("themeMode", value.name);

  bool get isLogin => userToken.isNotEmpty;

  String get userToken => _preference.getString("user_token") ?? "";

  set userToken(String value) => _preference.setString("user_token", value);

  /* UserModel? get user => _getData('user', UserModel.fromJson);

  set user(UserModel? value) => _setData('user', value?.toJson());*/

  Locale? get locale =>
      _preference.getString("locale") != null ? Locale(_preference.getString("locale") ?? "en") : null;

  set locale(Locale? value) =>
      value == null ? _preference.remove("locale") : _preference.setString("locale", value.languageCode);

  bool get showIntro => _preference.getBool("show_intro") ?? true;

  set showIntro(bool value) => _preference.setBool("show_intro", value);

  String? get currentLanguageCode => _preference.getString("language_code");

  set currentLanguageCode(String? value) =>
      value == null ? _preference.remove("language_code") : _preference.setString("language_code", value);

  _setData(String key, Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      _preference.remove(key);
    }
    _preference.setString(key, jsonEncode(json));
  }

  T? _getData<T extends Object>(String key, T Function(Map<String, dynamic> json) parser) {
    if (_preference.containsKey(key)) {
      var value = _preference.get(key);
      if (value != "null" && value is String && value.isNotEmpty) {
        return parser(jsonDecode(value));
      }
    }
    return null;
  }

  List<T>? _getDataList<T extends Object>(String key, T Function(Map<String, dynamic> json) parser) {
    if (_preference.containsKey(key)) {
      var value = _preference.getStringList(key);
      if (value is List<String> && value.isNotEmpty) {
        return (value).map((e) => parser(jsonDecode(e))).toList();
      }
    }
    return null;
  }

  _setListData(String key, List<Map<String, dynamic>>? jsonList) {
    if (jsonList == null || jsonList.isEmpty) {
      _preference.remove(key);
    }
    _preference.setStringList(key, jsonList?.map((e) => jsonEncode(e)).toList() ?? []);
  }
}
