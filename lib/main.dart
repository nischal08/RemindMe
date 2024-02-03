import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me/bloc/news_bloc.dart';
import 'package:remind_me/bloc/reminder_bloc.dart';
import 'package:remind_me/bloc/weather_bloc.dart';
import 'package:remind_me/data/enum/reminder_priority.dart';
import 'package:remind_me/utils/background_event_fetch.dart';
import 'package:remind_me/utils/notification.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/screens/splash_screen.dart';
import 'package:remind_me/styles/themes.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

init() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(ReminderPriorityAdapter());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //This function used to run program on 15 minutes interval on background
    BackgroundEventFetch.initiateBackgroundFetch();
    NotificationUtil.init();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
