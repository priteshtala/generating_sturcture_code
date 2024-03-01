library app_icon_generator;

import 'dart:io';

import 'src/helper_function.dart';

void main(List<String> args) {
  _init(args[0]);
}

Future<void> _init(String path) async {
  final decodedImage = getImageDimension(imagePath: "$path/required_files/app_icon.png");
  if (decodedImage == null) return;
  resizeImage(decodedImage: decodedImage, path: path);

  // if (decodedImage.height == 1024 && decodedImage.width == 1024) {
  // } else {
  //   print("Error => image size should be 1024 x 1024 but it is ${decodedImage.height} x ${decodedImage.width}");
  //   //ProcessResult result = await Process.run("bash", [""]);
  //   return;
  //   //_init(path);
  // }
}
