import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart';

class Utils {
  static Future<bool> fileNotExists(String path) async {
    bool exists = await File(path).exists();
    return !exists;
  }

  static Future<void> saveFile(String filePath, String data) async {
    await File(filePath).writeAsString(data, flush: true);
  }

  static Future<void> renameAndroid(String filePath, String appName) async {
    String data = await File(filePath).readAsString();
    XmlDocument document = XmlDocument.parse(data);
    var application =
        document.children.first.findAllElements('application').first;
    application.setAttribute('android:label', appName);

    await saveFile(filePath, document.toXmlString());
    _printFinishMessage('android');
  }

  static Future<void> renameIOS(String filePath, String appName) async {
    String data = await File(filePath).readAsString();
    XmlDocument document = XmlDocument.parse(data);
    var keys = document
        .findElements('plist')
        .first
        .findElements('dict')
        .first
        .children;

    // Removing xml elements which are generated due to line breaks (this xml parser is creating xml element as 'XmlText' for line breaks)
    keys.removeWhere((element) => element is XmlText);
    for (int i = 0; i < keys.length; i++) {
      // Will be true if google is already configured
      if (keys[i].innerText == 'CFBundleDisplayName') {
        var value = XmlElement(XmlName('string'));
        value.innerText = appName;
        keys.removeAt(i + 1);
        keys.insert(i + 1, value);
      }
    }
    await saveFile(filePath, document.toXmlString(pretty: true));
    _printFinishMessage('ios');
  }

  static Future<void> renameWeb(String filePath, String appName) async {
    String data = await File(filePath).readAsString();
    Map<String, dynamic> document = jsonDecode(data);
    document.containsKey('name') ? document['name'] = appName : logMessage('');
    document.containsKey('short_name')
        ? document['short_name'] = appName
        : logMessage('');
    var encoder = const JsonEncoder.withIndent("     ");
    String prettified = encoder.convert(document);
    await saveFile(filePath, prettified);
    _printFinishMessage('web');
  }

  static Future<void> renameWindows(String filePath, String appName) async {
    String data = await File(filePath).readAsString();
    var appNameLine = RegExp(r'set\(BINARY_NAME.*').firstMatch(data)?.group(0);
    if (appNameLine != null) {
      data = data.replaceAll(appNameLine, """set(BINARY_NAME "$appName")""");
    }
    await saveFile(filePath, data);
    _printFinishMessage('windows');
  }

  static void _printFinishMessage(String platform) {
    logMessage('✅ FINISHED RENAMING [${platform.toUpperCase()}] PROJECT\n');
  }

  static void printNoConfigFound(String platform) {
    logMessage(
        '🧐 NO CONFIGURATION FOUND FOR <${platform.toUpperCase()}> PROJECT');
  }

  static void logMessage(String message) {
    // ignore: avoid_print
    print(message);
  }
}