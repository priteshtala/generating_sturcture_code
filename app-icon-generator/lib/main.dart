library app_icon_generator;

import 'dart:io';
import 'src/helper_function.dart';

const message =
    "******************* Note: You have to add your app icon path inside the required_files folder *******************";

void main(List<String> args) {
  _init(args[0]);
}

void _init(String path) {
  print(message);
  stdout.write("Enter y to continue :: ");
  final userInput = stdin.readLineSync();
  if (userInput == null || userInput.isEmpty || userInput.trim() != 'y') {
    _init(path);
    return;
  }
  final decodedImage = getImageDimension(imagePath: "$path/required_files/app_icon.png");
  if (decodedImage == null) return;
  if (decodedImage.height == 1024 && decodedImage.width == 1024) {
    resizeImage(decodedImage: decodedImage, path: path);
  } else {
    print("Error => image size should be 1024 x 1024 but it is ${decodedImage.height} x ${decodedImage.width}");
    return;
    //_init(path);
  }
}
