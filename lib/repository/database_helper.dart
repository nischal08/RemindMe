import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:remind_me/models/reminder_model.dart';

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

  static getBoxItem(
      {required String key, required String boxId}) async {
    var box = await Hive.openBox(boxId);
        log(box.get(key, defaultValue: null).toString());
    return box.get(key, defaultValue: null);
  }

  
}
