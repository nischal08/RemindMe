import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:remind_me/data/image_constants.dart';
import 'package:remind_me/main.dart';
import 'package:remind_me/screens/home_navigation_screen.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/utils/navigation_util.dart';
import 'package:remind_me/widgets/alert_bottom_sheet.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  bool isInit = true;
  bool showDialog = true;
  bool isPaused = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are used for coming back to pervious from setting screen without giving the permission
    switch (state) {
      case AppLifecycleState.resumed:
        if (isPaused) {
          _getPermission(showNotification: true);
          FocusManager.instance.primaryFocus?.unfocus();
          isPaused = false;
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        isPaused = true;
        FocusManager.instance.primaryFocus?.unfocus();
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      WidgetsBinding.instance.addObserver(this);
      if (mounted) {
        _onSubmit();
      }
      isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onSubmit() async {
    await _getPermission();
  }

//This function will not let you go to other screen without giving all the requirement permission
  _getPermission({bool showNotification = false}) async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    LocationPermission requestLocationStatus =
        await Geolocator.requestPermission();

    if ((requestLocationStatus == LocationPermission.always ||
            requestLocationStatus == LocationPermission.whileInUse) &&
        (Platform.isIOS
            ? true
            : ((await Permission.notification.status ==
                    PermissionStatus.granted) ||
                (await Permission.notification.status ==
                    PermissionStatus.limited)))) {
      if (context.mounted) {
        _navigateCall();
      }
    } else {
      if (mounted && showDialog) {
        showDialog = false;
        await AlertBottomSheet.showAlertBottomSheet(
          context,
          iconImage: AppImage.alertIcon,
          isDismissible: false,
          enableDrag: false,
          okBgColor: AppColors.primaryColor,
          title: "Handle Permisson",
          description: Platform.isIOS
              ? "Access to your current location is vital for generating a weather data based on your proximity and send reminder notifications. If you do not grant permission, we won't be able to provide you with a personalized list of merchants. Please tap 'OK' to proceed and enable to offer you the best possible experience."
              : "Please press OK to accept the required permission in settings i.e. (Location and Notification)",
          okFunc: () async {
            Navigator.pop(context);
            openAppSettings();
          },
          isCancelButton: false,
        );
        showDialog = true;
      }
    }
  }

  _navigateCall() async {
    navigateReplacement(context, const HomeNavigationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Center(
        child: Image.asset(AppImage.logoImage, height: 150, width: 150),
      ),
    ));
  }
}
