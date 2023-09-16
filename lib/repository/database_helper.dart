import 'package:hive/hive.dart';

class DatabaseHelper {
  static deleteBoxItem({required String key, required String boxId}) async {
    var box = await Hive.openBox(boxId);
    box.delete(key);
  }

  static addBoxItem(
      {required String key,
      required dynamic value,
      required String boxId}) async {
    var box = await Hive.openBox(boxId);
    box.put(key, value);
  }

  static dynamic getBoxItem(
      {required String key, required String boxId}) async {
    var box = await Hive.openBox(boxId);
    return box.get(key, defaultValue: null);
  }
}
