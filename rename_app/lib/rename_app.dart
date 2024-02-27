library rename_app;

import '../main.dart';
import 'utils.dart';

class RenameApp {
  static Future<void> android(String android) async {
    if (await Utils.fileNotExists(androidManifestFile)) {
      Utils.printNoConfigFound('android');
      return;
    }

    if (android.isEmpty) {
      return;
    }

    await Utils.renameAndroid(androidManifestFile, android);
  }

  static Future<void> ios(String ios) async {
    if (await Utils.fileNotExists(iosPlistPath) || ios.isEmpty) {
      Utils.printNoConfigFound('ios');
      return;
    }

    if (ios.isEmpty) {
      return;
    }

    await Utils.renameIOS(iosPlistPath, ios);
  }

  static Future<void> web(String web) async {
    if (await Utils.fileNotExists(webManifestPath)) {
      Utils.printNoConfigFound('web');
      return;
    }

    if (web.isEmpty) {
      return;
    }

    await Utils.renameWeb(webManifestPath, web);
  }

  static void mac(String mac) {}
  static Future<void> windows(String windows) async {
    if (await Utils.fileNotExists(windowsCmakeListsPath)) {
      Utils.printNoConfigFound('windows');
      return;
    }

    if (windows.isEmpty) {
      return;
    }

    await Utils.renameWindows(windowsCmakeListsPath, windows);
  }
}