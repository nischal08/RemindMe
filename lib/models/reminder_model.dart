import 'package:hive/hive.dart';
import 'package:remind_me/data/enum/reminder_priority.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String descp;
  @HiveField(2)
  final ReminderPriority priority;

  ReminderModel({
    required this.title,
    required this.descp,
    required this.priority,
  });

  // @override
  // String toString() => title;
}
