// import 'package:flutter_local_notifications_linux/flutter_local_notifications_linux.dart';

// class NotificationService {
//   static final NotificationService _instance = NotificationService();
//   static NotificationService getInstance() => _instance;
//   late LinuxFlutterLocalNotificationsPlugin _localNotifications;
//   void init() {
//     _localNotifications = LinuxFlutterLocalNotificationsPlugin();
//     const initSettings = LinuxInitializationSettings(
//       defaultActionName: 'severingthing',
//       //defaultSuppressSound: true,
//       //defaultSound: AssetsLinuxSound('default_sound.mp3'),
//       //defaultIcon:  AssetsLinuxIcon('icon.png')
//     );
//     _localNotifications.initialize(initSettings);
//   }

//   Future<void> showNotification(String title, String body) async {
//     const details = LinuxNotificationDetails(
//       timeout: LinuxNotificationTimeout(100),
//       //icon: AssetsLinuxIcon('details_icon.png'),
//     );

//     await _localNotifications.show(0, title, body,
//         notificationDetails: details);
//   }
// }

import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final checkSuppportNotificationApp =
      Platform.isIOS || Platform.isMacOS || Platform.isAndroid;

  static final NotificationService _instance = NotificationService();
  static NotificationService getInstance() => _instance;

  late FlutterLocalNotificationsPlugin _localNotifications;

  void init() {
    if (checkSuppportNotificationApp) {
      _localNotifications = FlutterLocalNotificationsPlugin();
      //fix to ios
      if (Platform.isIOS || Platform.isMacOS) {
        _requestIOSPermission();
      }
      const initSettingAndroid = AndroidInitializationSettings('severingthing');
      const initSettingIOS = IOSInitializationSettings();
      const initializationSettingsMacOS = MacOSInitializationSettings();

      const initSettings = InitializationSettings(
          android: initSettingAndroid,
          iOS: initSettingIOS,
          macOS: initializationSettingsMacOS);

      _localNotifications.initialize(initSettings);
    } else {
      // Web ,Window,linux
    }
  }

  void _requestIOSPermission() {
    _localNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(badge: true, sound: true);
  }

  Future<void> showNotification(String title, String body) async {
    if (checkSuppportNotificationApp) {
      const androidChannel = AndroidNotificationDetails(
          'channel id', 'channel name', 'channel description',
          importance: Importance.max,
          priority: Priority.high,
          timeoutAfter: 5000,
          styleInformation: DefaultStyleInformation(true, true));

      const iosChannel = IOSNotificationDetails(presentSound: true);

      const macOSChannel = MacOSNotificationDetails(presentSound: true);

      const platformChannelSpecifics = NotificationDetails(
          android: androidChannel, iOS: iosChannel, macOS: macOSChannel);

      await _localNotifications.show(0, title, body, platformChannelSpecifics);
    } else {
      // Web ,Window,linux
    }
  }
}
