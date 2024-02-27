import 'dart:io';

import './src/image/image.dart' as image;

void main(List<String> args) {
  validateImagePath();
  // String imagePath = validateImagePath();
  //
  // try {
  //   final decodedImage = image.decodeImage(File(imagePath).readAsBytesSync());
  // } catch (e) {
  //   print(e);
  //   imagePath = validateImagePath();
  //   print(imagePath);
  // }
  //if (decodedImage == null) return;
  // while (decodedImage.height == 1024 || decodedImage.width == 1024) {
  //
  //   print("*************** Your current image size is ${decodedImage.height} x ${decodedImage.width} but it should be 1024 x 1024 ***************");
  //
  // }

  //Utils.validateImageSize(imagePath: input);
  //print("${imagePath}");
}

String? validateImagePath() {
  print("************** Please enter image path Note: Image should be size of 1024 x 1024 ***************");
  var input = stdin.readLineSync();
  while (input == null || input.isEmpty) {
    print("*************** Please enter image path ***************");
    input = stdin.readLineSync();
  }

  while (!(input!.contains(".png") || input.contains(".jpg") || input.contains(".jpeg"))) {
    print("*************** image should be PNG JPG or Jpeg ***************");
    input = stdin.readLineSync();
  }

  try {
    final decodedImage = image.decodeImage(File(input).readAsBytesSync());
    print(decodedImage);

    if (decodedImage != null) {
      if (decodedImage.height == 1024 && decodedImage.width == 1024) {
        print("ALLLLLL OKkk");
      } else {
        print("Error => your current image size is ${decodedImage.height} x ${decodedImage.width} but it should be 1024 x 1024");
        input = validateImagePath();
      }
    }
  } catch (e) {
    print(e);
    input = validateImagePath();
  }
  return input;
}

// if (args.isEmpty) {
//   print("Error ********** Please enter path of image ************");
//   return;
// }
// final imagePath = args[0];
// Utils.validateImageSize(imagePath: imagePath);
