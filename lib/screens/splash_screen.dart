import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remind_me/data/image_constants.dart';
import 'package:remind_me/screens/home_navigation_screen.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/utils/navigation_util.dart';
import 'package:remind_me/utils/permission_handler.dart';

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
    // These are used for coming back to pervious from setting screen without giving the permission
    switch (state) {
      case AppLifecycleState.resumed:
        if (isPaused && mounted) {
          PermissionHandler.getPermission(context, onAction: navigateCall);
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
    super.didChangeAppLifecycleState(state);
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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

  _onSubmit() async {
    await PermissionHandler.getPermission(context, onAction: navigateCall);
  }

  navigateCall() async {
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
        child: Image.asset(AppImage.logoImage, height: 140.h, width: 140.h),
      ),
    ));
  }
}
