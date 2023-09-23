import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me/bloc/news_bloc.dart';
import 'package:remind_me/bloc/reminder_bloc.dart';
import 'package:remind_me/bloc/weather_bloc.dart';
import 'package:remind_me/data/background/background_event_fetch.dart';
import 'package:remind_me/data/enum/reminder_priority.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/screens/home_navigation_screen.dart';
import 'package:remind_me/screens/splash_screen.dart';
import 'package:remind_me/styles/themes.dart';
import 'package:remind_me/utils/navigation_util.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(ReminderPriorityAdapter());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      navigate(
        navKey.currentState!.context,
        HomeNavigationScreen(
          datetime: DateTime.parse(payload!),
        ),
      );
    }
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    if (payload != null) {
      navigate(
        navKey.currentState!.context,
        HomeNavigationScreen(
          datetime: DateTime.parse(payload),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    //This function used to run program on 15 minutes interval on background
    BackgroundEventFetch.initiateBackgroundFetch();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //These are the configuration of showing notification
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
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
        BlocProvider(
          create: (context) => NewsBloc(),
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
