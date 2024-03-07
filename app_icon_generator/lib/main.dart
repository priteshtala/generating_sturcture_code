library app_icon_generator;

import 'dart:io';
import 'src/helper_function.dart';

void main(List<String> args) {
  print(args);
  final notificationIcon = args[1] == 'true' ? true : false;
  print("===============> ${notificationIcon}");
  _init(path: args[0], notificationIcon: notificationIcon);
}

Future<void> _init({required String path, required bool notificationIcon}) async {
  String? notificationIconPath;
  if (notificationIcon) notificationIconPath = "$path/required_files/notification_icon.png";
  final iconRecord = getImageDimension(appIconPath: "$path/required_files/app_icon.png", notificationIconPath: notificationIconPath);
  if (iconRecord == null) return;

  resizeImage(appIcon: iconRecord.appIcon!, path: path, notificationIcon: iconRecord.notificationIcon);

  // if (decodedImage == null) return;
  // resizeImage(decodedImage: decodedImage, path: path);
}

// if (decodedImage.height == 1024 && decodedImage.width == 1024) {
// } else {
//   print("Error => image size should be 1024 x 1024 but it is ${decodedImage.height} x ${decodedImage.width}");
//   //ProcessResult result = await Process.run("bash", [""]);
//   return;
//   //_init(path);
// }
