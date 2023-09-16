import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remind_me/bloc/reminder_bloc.dart';
import 'package:remind_me/data/enum/reminder_priority.dart';
import 'package:remind_me/models/reminder_model.dart';
import 'package:remind_me/reminder_screen.dart';
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
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          home: const ReminderScreen(),
        ),
      ),
    );
  }
}
