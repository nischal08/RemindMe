import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remind_me/main.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/repository/database_repository.dart';

class BackgroundEventFetch {
  static Future<void> backgroundFetchHeadlessTask(taskId) async {
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
      if (listData[i].isAfter(todayConvertedDate) ||
          (listData[i].day == todayConvertedDate.day &&
              listData[i].month == todayConvertedDate.month &&
              listData[i].year == todayConvertedDate.year)) {
        for (ReminderModel reminder in newRemindersList[listData[i]]!) {
          await flutterLocalNotificationsPlugin.show(
            i,
            reminder.title,
            reminder.descp,
            notificationDetails,
            payload: "Hello",
          );
        }
        break;
      }
    }

    BackgroundFetch.finish(taskId);
  }
}
