library app_icon_generator;

import 'dart:io';
import 'src/helper_function.dart';

const message =
    "******************* Note: You have to add your app icon path inside the required_files folder otherwise, it will take the default icon. *******************";

void main() {
  print(message);
  stdout.write("Enter y to continue :: ");
  final userInput = stdin.readLineSync();
  if (userInput == null || userInput.isEmpty || userInput.trim() != 'y') {
    main();
    return;
  }
  final decodedImage = getImageDimension(imagePath: "/Volumes/Data/ELaunchWork/Project/generating_sturcture_code/required_files/app_icon.jpg");
  if (decodedImage == null) return;
  if (decodedImage.height == 1024 && decodedImage.width == 1024) {
    resizeImage(decodedImage: decodedImage);
  } else {
    print("Error => image size should be 1024 x 1024 but it is ${decodedImage.height} x ${decodedImage.width}");
    main();
  }
}
