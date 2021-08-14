import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService();
  static NotificationService getInstance() => _instance;
  late FlutterLocalNotificationsPlugin _localNotifications;

  void init() {
    _localNotifications = FlutterLocalNotificationsPlugin();
    //fix to ios
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    const initSettingAndroid = AndroidInitializationSettings('severingthing');
    const initSettingIOS = IOSInitializationSettings();

    const initSettings = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);

    _localNotifications.initialize(initSettings);
  }

  void _requestIOSPermission() {
    _localNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(badge: true, sound: true);
  }

  void showNotification(String title, String body) async {
    const androidChannel = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        importance: Importance.max,
        priority: Priority.high,
        timeoutAfter: 5000,
        styleInformation: DefaultStyleInformation(true, true));

    const iosChannel = IOSNotificationDetails(presentSound: true);
    const platformChannelSpecifics =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    await _localNotifications.show(0, title, body, platformChannelSpecifics);
  }
}
