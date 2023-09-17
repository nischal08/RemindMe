import 'package:remind_me/data/keys_data.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/repository/database_helper.dart';

class DatabaseRepository {
  static Future<Map> getReminders() async {
    final Map reminderData = await DatabaseHelper.getBoxItem(
            key: AppKeys.reminderKey, boxId: AppKeys.reminderBoxId) ??
        {};

    return reminderData;
  }

  static Future<void> addReminders(
      Map<DateTime, List<ReminderModel>> data) async {
    await DatabaseHelper.addBoxItem(
        key: AppKeys.reminderKey, boxId: AppKeys.reminderBoxId, value: data);
  }

  static Future<void> addWeatherData(Map<String, dynamic> data) async {
    await DatabaseHelper.addBoxItem(
        key: AppKeys.weatherKey, boxId: AppKeys.weatherBoxId, value: data);
  }

  static Future<Map?> getWeatherData() async {
    return await DatabaseHelper.getBoxItem(
        key: AppKeys.weatherKey, boxId: AppKeys.weatherBoxId);
  }

  static Future<void> deleteAllReminders() async {
    await DatabaseHelper.deleteBoxItem(
        key: AppKeys.reminderKey, boxId: AppKeys.reminderBoxId);
  }
}
