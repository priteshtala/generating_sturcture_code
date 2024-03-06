import 'model/android.dart';
import 'model/ios.dart';
import 'model/notification.dart';

const androidFolderPath = "android/app/src/main/res";
const iosFolderPath = "ios/Runner/Assets.xcassets/AppIcon.appiconset";

final List<AndroidIconTemplate> androidTemplateList = [
  const AndroidIconTemplate(directoryName: "mipmap-hdpi", size: 72),
  const AndroidIconTemplate(directoryName: "mipmap-mdpi", size: 48),
  const AndroidIconTemplate(directoryName: "mipmap-xhdpi", size: 96),
  const AndroidIconTemplate(directoryName: "mipmap-xxhdpi", size: 144),
  const AndroidIconTemplate(directoryName: "mipmap-xxxhdpi", size: 192),
];

final List<IosIconTemplate> iosTemplateList = [
  const IosIconTemplate(fileName: "Icon-App-20x20@1x.png", size: 20),
  const IosIconTemplate(fileName: "Icon-App-20x20@2x.png", size: 40),
  const IosIconTemplate(fileName: "Icon-App-20x20@3x.png", size: 60),
  const IosIconTemplate(fileName: "Icon-App-29x29@1x.png", size: 29),
  const IosIconTemplate(fileName: "Icon-App-29x29@2x.png", size: 58),
  const IosIconTemplate(fileName: "Icon-App-29x29@3x.png", size: 87),
  const IosIconTemplate(fileName: "Icon-App-40x40@1x.png", size: 40),
  const IosIconTemplate(fileName: "Icon-App-40x40@3x.png", size: 80),
  const IosIconTemplate(fileName: "Icon-App-40x40@3x.png", size: 120),
  const IosIconTemplate(fileName: "Icon-App-60x60@2x.png", size: 120),
  const IosIconTemplate(fileName: "Icon-App-60x60@3x.png", size: 180),
  const IosIconTemplate(fileName: "Icon-App-76x76@1x.png", size: 76),
  const IosIconTemplate(fileName: "Icon-App-76x76@2x.png", size: 152),
  const IosIconTemplate(fileName: "Icon-App-83.5x83.5@2x.png", size: 167),
  const IosIconTemplate(fileName: "Icon-App-1024x1024@1x.png", size: 1024),
];
final List<NotificationIconTemplate> notificationTemplateList = [
  const NotificationIconTemplate(directoryName: "drawable-hdpi", size: 36),
  const NotificationIconTemplate(directoryName: "drawable-mdpi", size: 24),
  const NotificationIconTemplate(directoryName: "drawable-xhdpi", size: 48),
  const NotificationIconTemplate(directoryName: "drawable-xxhdpi", size: 72),
];
