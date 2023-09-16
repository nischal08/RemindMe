import 'package:remind_me/data/enum/reminder_priority_enum.dart';

class ReminderModel {
  final String title;
  final String descp;
  final PriorityEnum priority;

  ReminderModel({
    required this.title,
    required this.descp,
    required this.priority,
  });

  @override
  String toString() => title;
}
