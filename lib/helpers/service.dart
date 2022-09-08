import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class NoificationsApi {
  NoificationsApi();
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> notificationInitialize() async {
    tz.initializeTimeZones();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('quran');
    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings();
    MacOSInitializationSettings initializationSettingsMacOS =
        const MacOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // static Future<void> repeatedNotification(
  //   String verse,
  // ) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //           'repeating channel id', 'Repeating Notification',
  //           channelDescription: 'repeating description',
  //           styleInformation: BigTextStyleInformation(''));

  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     1,
  //     "Quran",
  //     verse,
  //     RepeatInterval.hourly,
  //     platformChannelSpecifics,
  //     androidAllowWhileIdle: true,
  //   );
  // }

  static Future<void> repeat(String verse) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'repeating channel id', 'Repeating Notification',
            channelDescription: 'repeating description',
            styleInformation: BigTextStyleInformation(''));

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      'Quran',
      verse,
      platformChannelSpecifics,
    );
  }
}
