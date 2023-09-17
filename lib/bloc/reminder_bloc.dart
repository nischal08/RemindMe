import 'package:bloc/bloc.dart';
import 'package:remind_me/bloc/events/reminder_event.dart';
import 'package:remind_me/data/response/app_response.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/repository/database_repository.dart';
//These logic is for adding, deleting, editing the reminder in the hive database
class ReminderBloc extends Bloc<ReminderEvent,
    AppResponse<Map<DateTime, List<ReminderModel>>>> {
  ReminderBloc() : super(AppResponse.loading({})) {
    on<AddReminderEvent>(
      (event, emit) async {
        if (state.data![event.selectedCalendarDate] != null) {
          state.data![event.selectedCalendarDate]?.add(event.reminder);
        } else {
          state.data![event.selectedCalendarDate] = [event.reminder];
        }
        DatabaseRepository.addReminders(state.data!).then((value) {
          emit(AppResponse.completed(state.data));
        }).onError((error, stackTrace) {
          emit(AppResponse.error(error.toString()));
        });
      },
    );
    on<EditReminderEvent>(
      (event, emit) async {
        if (state.data![event.selectedCalendarDate] != null) {
          state.data![event.selectedCalendarDate]!.removeAt(event.itemIndex);
          state.data![event.selectedCalendarDate]!
              .insert(event.itemIndex, event.reminder);
        }
        DatabaseRepository.addReminders(state.data!).then((value) {
          emit(AppResponse.completed(state.data));
        }).onError((error, stackTrace) {
          emit(AppResponse.error(error.toString()));
        });
      },
    );

    on<DeleteReminderEvent>(
      (event, emit) async {
        emit(AppResponse.loading(state.data));
        if (state.data![event.selectedCalendarDate]!.length == 1) {
          state.data!.remove(event.selectedCalendarDate);
        } else {
          state.data![event.selectedCalendarDate]!.remove(event.reminder);
        }
        DatabaseRepository.addReminders(state.data!).then((value) {
          emit(AppResponse.completed(state.data));
        }).onError((error, stackTrace) {
          emit(AppResponse.error(error.toString()));
        });
      },
    );
    on<GetReminderEvent>(
      (event, emit) async {
        emit(AppResponse.loading({}));
        await DatabaseRepository.getReminders().then((Map value) {
          Map<DateTime, List<ReminderModel>> newState = {};
          value.forEach((key, value) {
            newState[key] =
                (value as List).map((e) => (e as ReminderModel)).toList();
          });
          emit(AppResponse.completed(newState));
        }).onError((error, stackTrace) {
          emit(AppResponse.error(error.toString()));
        });
      },
    );
  }
}
