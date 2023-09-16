import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:remind_me/bloc/events/reminder_event.dart';
import 'package:remind_me/data/response/app_response.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/repository/database_repository.dart';

class ReminderBloc extends Bloc<ReminderEvent,
    AppResponse<Map<DateTime, List<ReminderModel>>>> {
  ReminderBloc() : super(AppResponse.loading({})) {
    on<AddReminderEvent>(
      (event, emit) async {
        emit(AppResponse.loading({}));
        if (state.data![event.selectedCalendarDate] != null) {
          state.data![event.selectedCalendarDate]?.add(event.reminder);
        } else {
          state.data![event.selectedCalendarDate] = [event.reminder];
        }
        DatabaseRepository.addReminders(state.data!).then((value) {
          emit(AppResponse.completed(state.data));
          //Put this bloc
        }).onError((error, stackTrace) {
          log(error.toString());
          emit(AppResponse.error(error.toString()));
        });
      },
    );
    on<GetReminderEvent>(
      (event, emit) async {
        emit(AppResponse.loading());
        await DatabaseRepository.getReminders().then((Map value) {
          // log((value.keys.toList()[0] as DateTime).toString());
          // emit(AppResponse.completed(
          //    value));
          Map<DateTime, List<ReminderModel>> newState = {};
          value.forEach((key, value) {
            newState[key] =
                (value as List).map((e) => (e as ReminderModel)).toList();
          });
          emit(AppResponse.completed(newState));
        }).onError((error, stackTrace) {
          log(error.toString(), name: "Reminder Bloc");
          // emit(AppResponse.error(error.toString()));
        });
      },
    );
  }
}
