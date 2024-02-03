import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remind_me/utils/notification.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/repository/database_repository.dart';

class BackgroundEventFetch {
  //This function is used to show notification on the device
  static Future<void> showNotification() async {
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

    listData.sort(
      (a, b) {
        return a.compareTo(b);
      },
    );

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
          await NotificationUtil.flutterLocalNotificationsPlugin.show(
            i,
            reminder.title,
            reminder.descp,
            notificationDetails,
            payload: listData[i].toString(),
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
      // This function will running every 15 minutes interval
      if (taskId == "flutter_background_fetch") {
        await showNotification();
      }
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      //This function run after the completion of 15 minutes interval, here we can stop the running program.
      BackgroundFetch.finish(taskId);
    });
  }
}
