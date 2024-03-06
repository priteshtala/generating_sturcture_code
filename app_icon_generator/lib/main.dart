library app_icon_generator;

import 'dart:io';
import 'src/helper_function.dart';

void main(List<String> args) {
  print("===============> ${bool.parse(args[1])}");

  _init(path: args[0], notificationIcon: bool.parse(args[1]));
}

Future<void> _init({required String path, required bool notificationIcon}) async {
  String? notificationIconPath;
  if (notificationIcon) {
  } else {
    final decodedImage = getImageDimension(imagePath: "$path/required_files/app_icon.png");
    if (decodedImage == null) return;
    resizeImage(decodedImage: decodedImage, path: path);
  }
}

// if (decodedImage.height == 1024 && decodedImage.width == 1024) {
// } else {
//   print("Error => image size should be 1024 x 1024 but it is ${decodedImage.height} x ${decodedImage.width}");
//   //ProcessResult result = await Process.run("bash", [""]);
//   return;
//   //_init(path);
// }
