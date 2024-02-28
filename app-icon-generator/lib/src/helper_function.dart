import 'dart:io';
import 'package:app_icon_generator/src/constant.dart';
import 'package:app_icon_generator/src/image/image.dart' as image;

image.Image? getImageDimension({required String imagePath}) {
  try {
    final decodedImage = image.decodeImage(File(imagePath).readAsBytesSync());
    if (decodedImage == null) return null;
    return decodedImage;
  } catch (e) {
    print("error => $e");
  }
  return null;
}

void resizeImage({required image.Image decodedImage}) async {
  final resizedAndroidImageList = <File>[];
  final resizedIosImageList = <File>[];

  for (int i = 0; i < androidTemplateList.length; i++) {
    final androidDirectory = await Directory("$androidFolderPath/${androidTemplateList[i].directoryName}").create(recursive: true);
    final resizeImage = image.copyResize(decodedImage, width: androidTemplateList[i].size, height: androidTemplateList[i].size);
    final unit8List = image.encodePng(resizeImage);
    final file = File("${androidDirectory.path}/ic_launcher.png")..writeAsBytes(unit8List);
    print(file.path);
    resizedAndroidImageList.add(file);
  }

  final iosDirectory = await Directory(iosFolderPath).create(recursive: true);
  for (int i = 0; i < iosTemplateList.length; i++) {
    final resizeImage = image.copyResize(decodedImage, width: iosTemplateList[i].size, height: iosTemplateList[i].size);
    final unit8List = image.encodePng(resizeImage);
    final file = File("${iosDirectory.path}/${iosTemplateList[i].fileName}")..writeAsBytes(unit8List);
    resizedIosImageList.add(file);
  }

  final jsonFilePath = "/Volumes/Data/ELaunchWork/Project/generating_sturcture_code/app-icon-generator/lib/src/Contents.json";
  String jsonString = File(jsonFilePath).readAsStringSync();
  File("${iosDirectory.path}/Contents.json").writeAsString(jsonString);
}
