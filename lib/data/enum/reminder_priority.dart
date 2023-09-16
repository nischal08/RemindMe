import 'package:hive/hive.dart';

part 'reminder_priority.g.dart';

@HiveType(typeId: 2)
enum ReminderPriority {
  @HiveField(0)
  high,
  @HiveField(1)
  normal,
  @HiveField(2)
  low,
}
