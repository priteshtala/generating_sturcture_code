library rename_app;

import 'lib/rename_app.dart';
import 'lib/utils.dart';

String? android;
String? ios;
String? web;
String? mac;
String? windows;

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    Utils.logMessage(help);
    return;
  }
  parseArguments(arguments);
  Utils.logMessage('📱 Android App Name: $android');
  Utils.logMessage('📱 IOS App Name: $ios');
  Utils.logMessage('💻 Web App Name: $web');
  // Utils.logMessage('🖥 MAC App Name: $mac');
  Utils.logMessage('💻 Windows App Name: $windows\n\n');

  await RenameApp.android(android ?? '');
  await RenameApp.ios(ios ?? '');
  await RenameApp.web(web ?? '');
  // await RenameApp.mac(mac ?? '');
  await RenameApp.windows(windows ?? '');

  Utils.logMessage(
    "--------------------------------\n✅  RENAMED APPS SUCCESSFULLY!\n--------------------------------",
  );
}

void parseArguments(List<String> args) {
  for (var arg in args) {
    List<String> splitted = arg.split('=');
    if (splitted.length != 2) {
      Utils.logMessage(help);
      return;
    }
    if (splitted.first == "all") {
      android = splitted.last;
      ios = splitted.last;
      web = splitted.last;
      mac = splitted.last;
      windows = splitted.last;
      return;
    }
    // if (splitted.first == "android") {
    //   android = splitted.last;
    // }
    // if (splitted.first == "ios") {
    //   ios = splitted.last;
    // }
    // if (splitted.first == "web") {
    //   web = splitted.last;
    // }
    // if (splitted.first == "mac") {
    //   mac = splitted.last;
    // }
    // if (splitted.first == "windows") {
    //   windows = splitted.last;
    // }
    // if (splitted.first == "others") {
    //   android = android ?? splitted.last;
    //   ios = ios ?? splitted.last;
    //   web = web ?? splitted.last;
    //   mac = mac ?? splitted.last;
    //   windows = windows ?? splitted.last;
    // }
  }
}

const help =
    """XXX PLEASE PROVIDE THE APP NAME XXX\n\nYou can provide app name in the following ways\n1) Same name for all apps\n\t>  flutter pub run rename_app:main all="My App Name"\n2) Seperate name for specified platform(s) and same for all others\n\t> flutter pub run rename_app:main android="Anroid Name" ios="IOS Name" others="Others Name"\n3) Seperate name for each platform\n\t> flutter pub run rename_app:main android="Android Name" ios="IOS Name" web="Web Name" mac="Mac Name" windows="Windows Name" """;

const androidManifestFile = "android/app/src/main/AndroidManifest.xml";
const iosPlistPath = "ios/Runner/Info.plist";
const webManifestPath = "web/manifest.json";
const windowsCmakeListsPath = "windows/CMakeLists.txt";
