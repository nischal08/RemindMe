import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/main.dart';
import '/styles/app_colors.dart';
import '/styles/app_sizes.dart';

FToast fToast = FToast();

class GeneralToast {
  static showToast(String text, {bool isEmergency = false}) {
    final context = navKey.currentState!.context;
    final toast = StatefulBuilder(builder: (_, setState) {
      return Container(
        padding: const EdgeInsets.all(AppSizes.paddingLg / 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius),
          color:
              isEmergency ? AppColors.emergencyBgColor : AppColors.alertBgColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isEmergency
                ? AppColors.emergencyTextColor
                : AppColors.alertTextColor,
          ),
        ),
      );
    });
    fToast.init(context);
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(
        seconds: 2,
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
