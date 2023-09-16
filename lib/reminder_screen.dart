import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:remind_me/bloc/events/reminder_event.dart';
import 'package:remind_me/bloc/reminder_bloc.dart';
import 'package:remind_me/data/response/app_response.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/styles/styles.dart';
import 'package:remind_me/widgets/general_textfield.dart';
import 'package:table_calendar/table_calendar.dart';

import 'data/enum/reminder_priority.dart';
import 'data/response/status.dart';
import 'utils/general_toast.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  ReminderScreenState createState() => ReminderScreenState();
}

class ReminderScreenState extends State<ReminderScreen> {
  final todaysDate = DateTime.now();
  DateTime _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2022);
  final _lastCalendarDate = DateTime(3000);
  DateTime? selectedCalendarDate;
  final titleController = TextEditingController();
  final dateInput = TextEditingController();
  final descpController = TextEditingController();
  ReminderPriority currentPriority = ReminderPriority.normal;
  late Map<DateTime, List<ReminderModel>> allReminders;

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    _convertSelectedDateToTzDate();
    allReminders = {};
    BlocProvider.of<ReminderBloc>(context).add(GetReminderEvent());
    super.initState();
  }

  _convertSelectedDateToTzDate() {
    selectedCalendarDate = DateTime.parse(
        DateTime.parse(selectedCalendarDate.toString().substring(0, 10))
            .toString()
            .replaceAll("000", "00Z"));
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    currentPriority = ReminderPriority.normal;
    super.dispose();
  }

  // List<ReminderModel> _listOfDayEvents(DateTime dateTime) {
  //   return allReminders[dateTime] ?? [];
  // }

  _onAddReminder() async {
    if (titleController.text.isEmpty && descpController.text.isEmpty) {
      GeneralToast.showToast("Please enter title & description");
    } else {
      _convertSelectedDateToTzDate();
      BlocProvider.of<ReminderBloc>(context).add(AddReminderEvent(
          selectedCalendarDate!,
          reminder: ReminderModel(
              title: titleController.text,
              descp: descpController.text,
              priority: currentPriority)));
      log(allReminders.toString());
      titleController.clear();
      descpController.clear();
      GeneralToast.showToast("Reminder successfully added.");
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedCalendarDate!,
        firstDate: DateTime.now(),
        lastDate: _lastCalendarDate);

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      selectedCalendarDate = pickedDate;
      dateInput.text = formattedDate; //set output date to TextField value.
    } else {}
  }

  _showAddEventDialog() async {
    dateInput.text = DateFormat('yyyy-MM-dd').format(selectedCalendarDate!);
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Set Reminder',
                style: subTitleText,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GeneralTextField(
                    onTap: () async {
                      _showDatePicker();
                    },
                    readonly: true,
                    textInputAction: TextInputAction.next,
                    keywordType: TextInputType.text,
                    validate: (val) {},
                    controller: dateInput,
                    suffixIcon: Icons.calendar_month_outlined,
                    suffixIconColor: AppColors.primaryColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GeneralTextField(
                      textInputAction: TextInputAction.next,
                      keywordType: TextInputType.text,
                      validate: (val) {},
                      controller: titleController,
                      hintText: 'Enter Title'),
                  SizedBox(
                    height: 20.h,
                  ),
                  GeneralTextField(
                      textInputAction: TextInputAction.next,
                      keywordType: TextInputType.text,
                      validate: (val) {},
                      controller: descpController,
                      hintText: 'Enter Description'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: bodyText.copyWith(
                      color: AppColors.redColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _onAddReminder();
                  },
                  child: Text(
                    'Add',
                    style: bodyText.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ));
  }

  List<ReminderModel> _listOfDayEvents(DateTime dateTime) {
    return allReminders[dateTime] ?? [];
  }

  // List<ReminderModel> _is(DateTime dateTime) {
  //   return allReminders[dateTime] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.reminderBgColor,
      appBar: AppBar(
        title: Text(
          'RemindMe',
          style: titleText.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.reminderBgColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: Text(
          'Add Reminder',
          style: smallText.copyWith(
              color: AppColors.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocBuilder<ReminderBloc,
          AppResponse<Map<DateTime, List<ReminderModel>>>>(builder: (_, state) {
        switch (state.status) {
          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          case Status.ERROR:
            return const Center(
              child: Text("Database error"),
            );
          case Status.COMPLETED:
            allReminders = state.data!;
            log(selectedCalendarDate.toString());
            return Column(
              children: [
                TableCalendar(
                  focusedDay: _focusedCalendarDate,
                  // today's date
                  firstDay: _initialCalendarDate,
                  // earliest possible date
                  lastDay: _lastCalendarDate,
                  // latest allowed date
                  calendarFormat: CalendarFormat.month,
                  // default view when displayed
                  // default is Saturday & Sunday but can be set to any day.
                  // instead of day number can be mentioned as well.
                  weekendDays: const [DateTime.saturday],
                  // default is Sunday but can be changed according to locale
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  // height between the day row and 1st date row, default is 16.0
                  daysOfWeekHeight: 28.h,
                  // height between the date rows, default is 52.0
                  rowHeight: 40.h,

                  // this property needs to be added if we want to show events
                  eventLoader: _listOfDayEvents,
                  // Calendar Header Styling
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    headerMargin: EdgeInsets.zero,
                    headerPadding: EdgeInsets.only(bottom: 10.h),
                    titleTextStyle: smallText.copyWith(
                        color: Colors.white, fontSize: 18.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r))),
                    leftChevronIcon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 28,
                    ),
                    rightChevronIcon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  // Calendar Days Styling
                  daysOfWeekStyle: DaysOfWeekStyle(
                    // Weekend days color (Sat,Sun)
                    weekdayStyle: smallText.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    weekendStyle: smallText.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Calendar Dates styling
                  calendarStyle: CalendarStyle(
                    // Weekend dates color (Sat & Sun Column)
                    weekendTextStyle:
                        smallText.copyWith(color: Colors.green.shade400),
                    defaultTextStyle: smallText.copyWith(
                      color: Colors.white,
                    ),
                    // highlighted color for today
                    todayDecoration: BoxDecoration(
                      color: AppColors.todayDateColor,
                      shape: BoxShape.circle,
                    ),
                    // highlighted color for selected day
                    selectedDecoration: BoxDecoration(
                      color: AppColors.selectedDateColor,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                        color: Colors.green.shade400, shape: BoxShape.circle),
                  ),
                  selectedDayPredicate: (currentSelectedDate) {
                    // as per the documentation 'selectedDayPredicate' needs to determine
                    // current selected day
                    return (isSameDay(
                        selectedCalendarDate!, currentSelectedDate));
                  },
                  availableGestures: AvailableGestures.all,

                  onDaySelected: (selectedDay, focusedDay) {
                    // as per the documentation
                    if (!isSameDay(selectedCalendarDate, selectedDay)) {
                      setState(() {
                        selectedCalendarDate = selectedDay;
                        _focusedCalendarDate = focusedDay;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: (_listOfDayEvents(selectedCalendarDate!).isEmpty)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 32.h,
                                ),
                                SvgPicture.asset(
                                    "assets/images/no reminder.svg",
                                    height: 200),
                                Text(
                                  "No reminder for ${DateFormat.yMMMEd().format(selectedCalendarDate!)}",
                                  style: subTitleText.copyWith(
                                    color: AppColors.textLightGreyColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 32.h,
                                )
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  DateFormat.yMMMMEEEEd()
                                      .format(selectedCalendarDate!),
                                  style: smallText.copyWith(
                                      color: Colors.grey.shade500),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                ..._listOfDayEvents(selectedCalendarDate!).map(
                                  (myEvents) => ListTile(
                                    leading: const Icon(
                                      Icons.radio_button_checked,
                                      color: AppColors.primaryColor,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    title: Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: Text(myEvents.title),
                                    ),
                                    subtitle: Text(myEvents.descp),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            );

          default:
            return const SizedBox();
        }
      }),
    );
  }
}
