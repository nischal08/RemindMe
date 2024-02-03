import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/styles/app_sizes.dart';
import 'package:remind_me/styles/styles.dart';
import 'package:remind_me/widgets/general_elevated_button.dart';
import 'package:remind_me/widgets/general_text_button.dart';

class AlertBottomSheet {
  static showAlertBottomSheet(BuildContext context,
      {bool isSpacious = false,
      required String title,
      required String description,
      Widget? descriptionWidget,
      required String iconImage,
      // required List<String> list,
      VoidCallback? cancelFunc,
      VoidCallback? okFunc,
      String? okTitle,
      String? cancelTitle,
      bool isCancelButton = false,
      bool isDismissible = true,
      bool useOkTextButton = false,
      bool enableDrag = false,
      Color? cancelBgColor,
      Color? cancelFgColor,
      Color? okBgColor,
      Color? okFgColor}) async {
    // var header = context.locale == const Locale("en", "US")
    //     ? "${LocaleKeys.select.tr()} $title"
    //     : "$title ${LocaleKeys.select.tr()}";
    Widget okButton = useOkTextButton
        ? GeneralTextButton(
            fgColor: okFgColor ?? AppColors.whiteColor,
            height: 33.h,
            onPressed: okFunc,
            width: 145.w,
            borderRadius: 8.r,
            borderColor: AppColors.buttonGreyColor,
            isSmallText: true,
            bgColor: okBgColor ?? AppColors.defaultAlertOkBgColor,
            title: okTitle ?? "Ok",
          )
        : GeneralElevatedButton(
            fgColor: okFgColor ?? AppColors.whiteColor,
            height: 33.h,
            elevation: 0,
            onPressed: okFunc,
            width: 145.w,
            borderRadius: 8.r,
            isSmallText: true,
            bgColor: okBgColor ?? AppColors.defaultAlertOkBgColor,
            title: okTitle ?? "OK",
          );

    Widget cancelButton = GeneralElevatedButton(
      elevation: 0,
      borderRadius: 8.r,
      isSmallText: true,
      height: 33.h,
      width: 145.w,
      fgColor: cancelFgColor ?? AppColors.defaultAlertcancelFgColor,
      bgColor: cancelBgColor ?? AppColors.defaultAlertcancelBgColor,
      onPressed: cancelFunc ?? () => Navigator.pop(context),
      title: cancelTitle ?? "Cancel",
    );
    return await showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r))),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      context: context,
      builder: (bContext) => PopScope(
        canPop: false,
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isSpacious ? 40.h : 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                    ),
                    child: Text(
                      title,
                      style: subTitleText.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: isSpacious ? 17 : 14),
                    ),
                  ),
                  SizedBox(height: isSpacious ? 14.h : 8.h),
                  if (descriptionWidget != null) descriptionWidget,
                  if (descriptionWidget == null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: smallText.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: isSpacious ? 15 : 14,
                            color: AppColors.textSoftGreyColor),
                      ),
                    ),
                  SizedBox(
                    height: isSpacious ? 30.h : 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isCancelButton == true) cancelButton,
                      if (isCancelButton == true)
                        SizedBox(
                          width: 12.w,
                        ),
                      okButton,
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.padding * 6,
                  ),
                ],
              ),
              Positioned(
                top: -27,
                right: (MediaQuery.of(context).size.width / 2) - (28),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50.r,
                    ),
                    color: AppColors.whiteColor,
                  ),
                  padding: const EdgeInsets.all(AppSizes.padding / 2),
                  child: Image.asset(
                    iconImage,
                    width: 56,
                    // color: const Color(primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
