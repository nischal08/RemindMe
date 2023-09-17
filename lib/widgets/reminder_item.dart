import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remind_me/bloc/events/reminder_event.dart';
import 'package:remind_me/bloc/reminder_bloc.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/styles/styles.dart';
import 'package:remind_me/utils/general_toast.dart';

class ReminderItem extends StatelessWidget {
  final ReminderModel reminder;
  final DateTime selectedCalendarDate;
  final VoidCallback onEdit;
  const ReminderItem(
    this.selectedCalendarDate, {
    super.key,
    required this.reminder, required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(reminder.toString()),
      onDismissed: (direction) {
        context
            .read<ReminderBloc>()
            .add(DeleteReminderEvent(selectedCalendarDate, reminder: reminder));
        GeneralToast.showToast('${reminder.title} reminder deleted.');
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        bool delete = await _showDeleteConfirmation(context);
        return delete;
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(right: 8.h),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 25.h,
        ),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.radio_button_checked,
          color: AppColors.primaryColor,
        ),
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(reminder.title),
        ),
        subtitle: Text(reminder.descp),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_calendar_outlined),
              color: AppColors.primaryColor,
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.delete),
            //   color: AppColors.primaryColor,
            // ),
          ],
        ),
      ),
    );
  }

  _showDeleteConfirmation(context) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Do you want to delete reminder?',
                style: subTitleText,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Cancel',
                    style: bodyText.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    'Delete',
                    style: bodyText.copyWith(
                      color: AppColors.redColor,
                    ),
                  ),
                ),
              ],
            ));
  }
}
