import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remind_me/main.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/repository/database_repository.dart';

class BackgroundEventFetch {
  static Future<void> showNotification() async {
    log('[BackgroundFetch] Headless event received.');
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('reminderChannel', 'notificationChannel',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            playSound: true,
            sound: RawResourceAndroidNotificationSound("notification"));
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    Map remindersData = await DatabaseRepository.getReminders();
    Map<DateTime, List<ReminderModel>> newRemindersList = {};
    remindersData.forEach((key, value) {
      newRemindersList[key] =
          (value as List).map((e) => (e as ReminderModel)).toList();
    });
    List<DateTime> listData = newRemindersList.keys.toList();

    log(listData.toString(), name: "Before");
    listData.sort(
      (a, b) {
        return a.compareTo(b);
      },
    );
    log(listData.toString(), name: "After");

    DateTime todayConvertedDate = DateTime.parse(
        DateTime.parse(DateTime.now().toString().substring(0, 10))
            .toString()
            .replaceAll("000", "00Z"));
    for (var i = 0; i < listData.length; i++) {
      if (((listData[i].day == todayConvertedDate.day ||
              listData[i].day == todayConvertedDate.day + 1) &&
          listData[i].month == todayConvertedDate.month &&
          listData[i].year == todayConvertedDate.year)) {
        for (ReminderModel reminder in newRemindersList[listData[i]]!) {
          await flutterLocalNotificationsPlugin.show(
            i,
            reminder.title,
            reminder.descp,
            notificationDetails,
            payload:  listData[i].toString(),
          );
        }
        break;
      }
    }
  }

  static initiateBackgroundFetch() {
    BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true,
        ), (String taskId) async {
      if (taskId == "flutter_background_fetch") {
        await showNotification();
      }
      log('[BackgroundFetch] Event received.');
      // <-- Event callback
      // This callback is typically fired every 15 minutes while in the background.
      // IMPORTANT:  You must signal completion of your fetch task or the OS could
      // punish your app for spending much time in the background.
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Timeout callback
      log("[BackgroundFetch] TIMEOUT: $taskId");
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      BackgroundFetch.finish(taskId);
    });
  }
}
