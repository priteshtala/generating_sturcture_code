import 'dart:io';
import 'package:image/image.dart' as image;
import 'constant.dart';

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

void resizeImage({required image.Image decodedImage, required String path}) async {
  final resizedAndroidImageList = <File>[];
  final resizedIosImageList = <File>[];
  try {
    for (int i = 0; i < androidTemplateList.length; i++) {
      final androidDirectory = await Directory("$androidFolderPath/${androidTemplateList[i].directoryName}").create(recursive: true);
      final resizeImage = image.copyResize(decodedImage, width: androidTemplateList[i].size, height: androidTemplateList[i].size, maintainAspect: true);
      final unit8List = image.encodePng(resizeImage);
      final file = File("${androidDirectory.path}/ic_launcher.png")..writeAsBytes(unit8List);
      resizedAndroidImageList.add(file);
    }

    final iosDirectory = await Directory(iosFolderPath).create(recursive: true);
    for (int i = 0; i < iosTemplateList.length; i++) {
      final resizeImage = image.copyResize(decodedImage, width: iosTemplateList[i].size, height: iosTemplateList[i].size, maintainAspect: true);
      final unit8List = image.encodePng(resizeImage);
      final file = File("${iosDirectory.path}/${iosTemplateList[i].fileName}")..writeAsBytes(unit8List);
      resizedIosImageList.add(file);
    }

    final jsonFilePath = "$path/app_icon_generator/lib/src/Contents.json";
    String jsonString = File(jsonFilePath).readAsStringSync();
    File("${iosDirectory.path}/Contents.json").writeAsString(jsonString);

    print("********************* Generated Successfully *********************");
  } catch (e) {
    print("error => $e");
  }
}
