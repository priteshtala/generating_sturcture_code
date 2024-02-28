import 'dart:async';

import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bit_merge_mobile/packages/utils/permission/permission.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  late final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  final StreamController<NotificationResponse> _streamController = StreamController<NotificationResponse>.broadcast();
  final permissionHelper = PermissionHelper.notification;

  Stream<NotificationResponse> get onDidReceiveNotificationResponse => _streamController.stream;

  static const _categoryGeneralNotification = "azSecurity.general";
  static const _androidNotificationIcon = "@drawable/ic_notification";

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(_androidNotificationIcon);
    const iosSettings = DarwinInitializationSettings(
      notificationCategories: [
        DarwinNotificationCategory(
          _categoryGeneralNotification,
          options: {DarwinNotificationCategoryOption.allowAnnouncement},
        ),
      ],
    );
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _notificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  Future<bool> resolveNotificationPermission() async {
    final permissionResult = await permissionHelper.requestPermission();
    return permissionResult == PermissionResult.granted;
  }

  Future<void> resolvePlatformImplementation() async {
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
            const AndroidNotificationChannel(_categoryGeneralNotification, "General Notifications"));
  }

  Future<void> showGeneralNotification({required String title, String? body, String? payload}) async {
    final hasPermission = await resolveNotificationPermission();
    if (!hasPermission) return;
    const androidDetails = AndroidNotificationDetails(
      _categoryGeneralNotification,
      "General Notifications",
      icon: _androidNotificationIcon,
    );
    const iosDetails = DarwinNotificationDetails(categoryIdentifier: _categoryGeneralNotification);
    const notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    return _notificationsPlugin.show(Object.hashAll([title, body, payload]), title, body, notificationDetails,
        payload: payload);
  }

  void _onDidReceiveNotificationResponse(NotificationResponse details) {
    Log.debug("_onDidReceiveNotificationResponse -> $details -> ${details.payload}");
    _streamController.add(details);
  }

  Future<void> getAppLaunchDetails() async {
    final details = await _notificationsPlugin.getNotificationAppLaunchDetails();
    if (details == null) return;
    if (details.didNotificationLaunchApp && details.notificationResponse != null) {
      _streamController.add(details.notificationResponse!);
    }
  }
}
