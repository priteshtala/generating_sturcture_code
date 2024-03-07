import 'dart:io';
import 'package:image/image.dart' as image;
import 'constant.dart';

({image.Image? appIcon, image.Image? notificationIcon})? getImageDimension({
  required String appIconPath,
  String? notificationIconPath,
}) {
  if (notificationIconPath != null) {
    final appIcon = image.decodeImage(File(appIconPath).readAsBytesSync());
    final notificationIcon = image.decodeImage(File(notificationIconPath).readAsBytesSync());
    return (appIcon: appIcon, notificationIcon: notificationIcon);
  } else {
    final appIcon = image.decodeImage(File(appIconPath).readAsBytesSync());
    return (appIcon: appIcon, notificationIcon: null);
  }
}

void resizeImage({required image.Image appIcon, required String path, image.Image? notificationIcon}) async {
  try {
    for (int i = 0; i < androidTemplateList.length; i++) {
      final androidDirectory = await Directory("$androidFolderPath/${androidTemplateList[i].directoryName}").create(recursive: true);
      final resizeImage = image.copyResize(appIcon, width: androidTemplateList[i].size, height: androidTemplateList[i].size, maintainAspect: true);
      final unit8List = image.encodePng(resizeImage);
      await File("${androidDirectory.path}/ic_launcher.png").writeAsBytes(unit8List);
    }

    final iosDirectory = await Directory(iosFolderPath).create(recursive: true);
    for (int i = 0; i < iosTemplateList.length; i++) {
      final resizeImage = image.copyResize(appIcon, width: iosTemplateList[i].size, height: iosTemplateList[i].size, maintainAspect: true);
      final unit8List = image.encodePng(resizeImage);
      await File("${iosDirectory.path}/${iosTemplateList[i].fileName}").writeAsBytes(unit8List);
    }

    final jsonFilePath = "$path/app_icon_generator/lib/src/contents.json";
    String jsonString = File(jsonFilePath).readAsStringSync();
    File("${iosDirectory.path}/Contents.json").writeAsString(jsonString);

    if (notificationIcon != null) {
      for (int i = 0; i < notificationTemplateList.length; i++) {
        final androidDirectory = await Directory("$androidFolderPath/${notificationTemplateList[i].directoryName}").create(recursive: true);
        final resizedIcon = image.copyResize(
          notificationIcon,
          width: notificationTemplateList[i].size,
          height: notificationTemplateList[i].size,
          maintainAspect: true,
        );
        final unit8List = image.encodePng(resizedIcon);
        await File("${androidDirectory.path}/ic_notification.png").writeAsBytes(unit8List);
      }
    }

    print("********************* Generated Successfully *********************");
  } catch (e) {
    print("error => $e");
  }
}

