import 'package:remind_me/data/keys_data.dart';
import 'package:remind_me/repository/database_helper_repository.dart';

class DatabaseRepository {
  Future<Map?> getReminders() async {
    final Map? reminderData = await DatabaseHelperRepository()
        .getBoxItem(key: AppKeys.reminderKey, boxId: AppKeys.reminderBoxId);

    return reminderData;
  }

  Future<void> addReminders(Map data) async {
    await DatabaseHelperRepository().addBoxItem(
        key: AppKeys.reminderKey, boxId: AppKeys.reminderBoxId, value: data);
  }

  Future<void> deleteAllReminders() async {
    await DatabaseHelperRepository()
        .deleteBoxItem(key: AppKeys.reminderKey, boxId: AppKeys.reminderBoxId);
  }
}
