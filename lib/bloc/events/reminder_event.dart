import 'package:remind_me/models/reminder_model.dart';

abstract class ReminderEvent {}

class AddReminderEvent extends ReminderEvent {
  final ReminderModel reminder;
  final DateTime selectedCalendarDate ;
  AddReminderEvent(this.selectedCalendarDate, {required this.reminder});
}
class DeleteReminderEvent extends ReminderEvent {
  final ReminderModel reminder;
  final DateTime selectedCalendarDate ;
  DeleteReminderEvent(this.selectedCalendarDate, {required this.reminder});
}

class GetReminderEvent extends ReminderEvent {
  
  GetReminderEvent();
}
