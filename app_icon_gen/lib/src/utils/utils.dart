import 'dart:convert';
import 'dart:io';

import 'package:app_icon_gen/src/model/android.dart';
import 'package:app_icon_gen/src/model/ios.dart';

import '../image/image.dart' as image;

class Utils {
  static final List<File> androidIconsFile = [], iosIconsFile = [];

  static void validateImageSize({required String imagePath}) {
    final decodedImage = image.decodeImage(File(imagePath).readAsBytesSync());
    if (decodedImage == null) return;
    while (decodedImage.height == 1024 || decodedImage.width == 1024) {

    }
    if (decodedImage.height < 1024 || decodedImage.width < 1024) {
      print("Error => ************** Your current image size is ${decodedImage.height} x ${decodedImage.width} but it should be 1024 x 1024");
      return;
    }
    Utils.generateIcon(decodedImage);
  }

  static Future<void> generateIcon(image.Image decodedImage) async {
    final androidList = AndroidIconTemplate.androidIconTemplateList;
    final iosList = IosIconTemplate.iosIconTemplateList;
    for (int i = 0; i < androidList.length; i++) {
      final dir = await Directory("android/${androidList[i].directory}").create(recursive: true);
      final file = File("${dir.path}/ic_launcher.png")
        ..writeAsBytesSync(
          image.encodePng(image.copyResize(decodedImage, height: androidList[i].size, width: androidList[i].size)),
        );
      androidIconsFile.add(file);
    }
    for (int i = 0; i < iosList.length; i++) {
      final dir = await Directory("ios/Assets.xcassets/AppIcon.appiconset").create(recursive: true);

      final file = File("${dir.path}/${iosList[i].name}.png")
        ..writeAsBytesSync(
          image.encodePng(image.copyResize(decodedImage, height: iosList[i].size, width: iosList[i].size)),
        );
      iosIconsFile.add(file);
    }
    print("====> androidIconsFile ${androidIconsFile}");
    print("====> iosList ${iosIconsFile}");

    final dir = await Directory("ios/Assets.xcassets/AppIcon.appiconset").create(recursive: true);
    String jsonString = jsonEncode(json);
    await File("${dir.path}/Content.json").writeAsString(jsonString);
  }
}

final json = {
  "images": [
    {"size": "60x60", "expected-size": "180", "filename": "180.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "3x"},
    {"size": "40x40", "expected-size": "80", "filename": "80.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "2x"},
    {"size": "40x40", "expected-size": "120", "filename": "120.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "3x"},
    {"size": "60x60", "expected-size": "120", "filename": "120.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "2x"},
    {"size": "57x57", "expected-size": "57", "filename": "57.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "1x"},
    {"size": "29x29", "expected-size": "58", "filename": "58.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "2x"},
    {"size": "29x29", "expected-size": "29", "filename": "29.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "1x"},
    {"size": "29x29", "expected-size": "87", "filename": "87.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "3x"},
    {"size": "57x57", "expected-size": "114", "filename": "114.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "2x"},
    {"size": "20x20", "expected-size": "40", "filename": "40.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "2x"},
    {"size": "20x20", "expected-size": "60", "filename": "60.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "iphone", "scale": "3x"},
    {
      "size": "1024x1024",
      "filename": "1024.png",
      "expected-size": "1024",
      "idiom": "ios-marketing",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "scale": "1x"
    },
    {"size": "40x40", "expected-size": "80", "filename": "80.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "2x"},
    {"size": "72x72", "expected-size": "72", "filename": "72.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "1x"},
    {"size": "76x76", "expected-size": "152", "filename": "152.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "2x"},
    {"size": "50x50", "expected-size": "100", "filename": "100.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "2x"},
    {"size": "29x29", "expected-size": "58", "filename": "58.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "2x"},
    {"size": "76x76", "expected-size": "76", "filename": "76.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "1x"},
    {"size": "29x29", "expected-size": "29", "filename": "29.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "1x"},
    {"size": "50x50", "expected-size": "50", "filename": "50.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "1x"},
    {"size": "72x72", "expected-size": "144", "filename": "144.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "2x"},
    {"size": "40x40", "expected-size": "40", "filename": "40.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "1x"},
    {"size": "83.5x83.5", "expected-size": "167", "filename": "167.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "2x"},
    {"size": "20x20", "expected-size": "20", "filename": "20.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "1x"},
    {"size": "20x20", "expected-size": "40", "filename": "40.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "ipad", "scale": "2x"},
    {
      "idiom": "watch",
      "filename": "172.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "38mm",
      "scale": "2x",
      "size": "86x86",
      "expected-size": "172",
      "role": "quickLook"
    },
    {
      "idiom": "watch",
      "filename": "80.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "38mm",
      "scale": "2x",
      "size": "40x40",
      "expected-size": "80",
      "role": "appLauncher"
    },
    {
      "idiom": "watch",
      "filename": "88.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "40mm",
      "scale": "2x",
      "size": "44x44",
      "expected-size": "88",
      "role": "appLauncher"
    },
    {
      "idiom": "watch",
      "filename": "102.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "41mm",
      "scale": "2x",
      "size": "45x45",
      "expected-size": "102",
      "role": "appLauncher"
    },
    {
      "idiom": "watch",
      "filename": "92.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "41mm",
      "scale": "2x",
      "size": "46x46",
      "expected-size": "92",
      "role": "appLauncher"
    },
    {
      "idiom": "watch",
      "filename": "100.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "44mm",
      "scale": "2x",
      "size": "50x50",
      "expected-size": "100",
      "role": "appLauncher"
    },
    {
      "idiom": "watch",
      "filename": "196.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "42mm",
      "scale": "2x",
      "size": "98x98",
      "expected-size": "196",
      "role": "quickLook"
    },
    {
      "idiom": "watch",
      "filename": "216.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "44mm",
      "scale": "2x",
      "size": "108x108",
      "expected-size": "216",
      "role": "quickLook"
    },
    {
      "idiom": "watch",
      "filename": "48.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "38mm",
      "scale": "2x",
      "size": "24x24",
      "expected-size": "48",
      "role": "notificationCenter"
    },
    {
      "idiom": "watch",
      "filename": "55.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "42mm",
      "scale": "2x",
      "size": "27.5x27.5",
      "expected-size": "55",
      "role": "notificationCenter"
    },
    {
      "idiom": "watch",
      "filename": "66.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "subtype": "45mm",
      "scale": "2x",
      "size": "33x33",
      "expected-size": "66",
      "role": "notificationCenter"
    },
    {
      "size": "29x29",
      "expected-size": "87",
      "filename": "87.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "idiom": "watch",
      "role": "companionSettings",
      "scale": "3x"
    },
    {
      "size": "29x29",
      "expected-size": "58",
      "filename": "58.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "idiom": "watch",
      "role": "companionSettings",
      "scale": "2x"
    },
    {
      "size": "1024x1024",
      "expected-size": "1024",
      "filename": "1024.png",
      "folder": "Assets.xcassets/AppIcon.appiconset/",
      "idiom": "watch-marketing",
      "scale": "1x"
    },
    {"size": "128x128", "expected-size": "128", "filename": "128.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "1x"},
    {"size": "256x256", "expected-size": "256", "filename": "256.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "1x"},
    {"size": "128x128", "expected-size": "256", "filename": "256.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "2x"},
    {"size": "256x256", "expected-size": "512", "filename": "512.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "2x"},
    {"size": "32x32", "expected-size": "32", "filename": "32.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "1x"},
    {"size": "512x512", "expected-size": "512", "filename": "512.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "1x"},
    {"size": "16x16", "expected-size": "16", "filename": "16.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "1x"},
    {"size": "16x16", "expected-size": "32", "filename": "32.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "2x"},
    {"size": "32x32", "expected-size": "64", "filename": "64.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "2x"},
    {"size": "512x512", "expected-size": "1024", "filename": "1024.png", "folder": "Assets.xcassets/AppIcon.appiconset/", "idiom": "mac", "scale": "2x"}
  ]
};
