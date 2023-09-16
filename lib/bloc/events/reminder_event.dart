import 'package:remind_me/models/reminder_model.dart';

abstract class ReminderEvent {}

class AddReminderEvent extends ReminderEvent {
  final Map<DateTime, List<ReminderModel>> reminders;
  AddReminderEvent({required this.reminders});
}

class GetReminderEvent extends ReminderEvent {
  
  GetReminderEvent();
}
