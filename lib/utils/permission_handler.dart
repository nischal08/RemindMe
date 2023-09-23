import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remind_me/data/image_constants.dart';
import 'package:remind_me/main.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/widgets/alert_bottom_sheet.dart';

class PermissionHandler {
  //This function will not let you go to other screen without giving all the requirement permission
  static getPermission(BuildContext context,
      {required VoidCallback onAction}) async {
    //
    bool isDenied = true;
    //
    isDenied = await Permission.notification.isDenied;
    await Permission.notification.isDenied.then((value) async {
      //
      if (value) {
        isDenied = value;
        //  await Permission.notification.request();
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
            .requestPermission();
      }
    });
    //
    LocationPermission requestLocationStatus =
        await Geolocator.requestPermission();
    if ((requestLocationStatus == LocationPermission.always ||
            requestLocationStatus == LocationPermission.whileInUse) &&
        (Platform.isIOS ? true : !(isDenied))) {
      onAction();
    } else {
      if (context.mounted) {
        await AlertBottomSheet.showAlertBottomSheet(
          context,
          iconImage: AppImage.alertIcon,
          isDismissible: true,
          enableDrag: false,
          cancelFunc: () {
            Navigator.pop(context);
            onAction();
          },
          cancelTitle: "Cancel",
          okBgColor: AppColors.primaryColor,
          title: "Handle Permisson",
          description: Platform.isIOS
              ? "Access to your current location is vital for generating a weather data based on your proximity and send reminder notifications. If you do not grant permission, we won't be able to provide you with a personalized list of merchants. Please tap 'OK' to proceed and enable to offer you the best possible experience."
              : "Please press OK to accept the required permission in settings i.e. (Location and Notification)",
          okFunc: () async {
            Navigator.pop(context);
            openAppSettings();
          },
          isCancelButton: true,
        );
      }
    }
  }
}
