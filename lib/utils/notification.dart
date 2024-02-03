import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remind_me/main.dart';
import 'package:remind_me/screens/home_navigation_screen.dart';
import 'package:remind_me/utils/navigation_util.dart';

class NotificationUtil {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() {
    //These are the configuration of showing notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      navigate(
        navKey.currentState!.context,
        HomeNavigationScreen(
          datetime: DateTime.parse(payload!),
        ),
      );
    }
  }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    if (payload != null) {
      navigate(
        navKey.currentState!.context,
        HomeNavigationScreen(
          datetime: DateTime.parse(payload),
        ),
      );
    }
  }
}
