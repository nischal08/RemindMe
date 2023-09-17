import 'dart:developer';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me/bloc/reminder_bloc.dart';
import 'package:remind_me/data/background/background_event_fetch.dart';
import 'package:remind_me/data/enum/reminder_priority.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/screens/home_navigation_screen.dart';
import 'package:remind_me/screens/reminder_screen.dart';
import 'package:remind_me/screens/splash_screen.dart';
import 'package:remind_me/styles/themes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(ReminderPriorityAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
  BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
      ), (String taskId) async {
    if (taskId == "flutter_background_fetch") {
      await BackgroundEventFetch.backgroundFetchHeadlessTask(taskId);
    }
    log('[BackgroundFetch] Event received.');
    // <-- Event callback
    // This callback is typically fired every 15 minutes while in the background.
    // IMPORTANT:  You must signal completion of your fetch task or the OS could
    // punish your app for spending much time in the background.
    BackgroundFetch.finish(taskId);
  }, (String taskId) async {
    // <-- Timeout callback
    log("[BackgroundFetch] TIMEOUT: $taskId");
    // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
    BackgroundFetch.finish(taskId);
  });
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }

    await Navigator.push(
      navKey.currentState!.context,
      MaterialPageRoute<void>(builder: (context) => const ReminderScreen()),
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: navKey.currentState!.context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReminderScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReminderBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'RemindMe',
          navigatorKey: navKey,
          builder: (context, child) => Overlay(
            initialEntries: [
              if (child != null) ...[
                OverlayEntry(
                  builder: (context) => child,
                ),
              ],
            ],
          ),
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
