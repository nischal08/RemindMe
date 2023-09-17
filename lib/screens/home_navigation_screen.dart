// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remind_me/screens/news_screen.dart';
import 'package:remind_me/screens/reminder_screen.dart';
import 'package:remind_me/screens/weather_screen.dart';
import 'package:remind_me/styles/app_colors.dart';

class HomeNavigationScreen extends StatefulWidget {
  final DateTime? datetime;
  const HomeNavigationScreen({Key? key, this.datetime}) : super(key: key);

  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _widgetOptions = <Widget>[
      ReminderScreen(datetime: widget.datetime),
      const WeatherScreen(),
      const NewsScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
            color: AppColors.primaryColor.withOpacity(0.9),
          ),
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.today_outlined,
                size: 24.h,
              ),
              activeIcon: Icon(
                Icons.today,
                size: 24.h,
              ),
              label: 'Reminder',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.cloud_outlined,
                size: 24.h,
              ),
              activeIcon: Icon(
                Icons.cloud,
                size: 24.h,
              ),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.newspaper_outlined,
                size: 24.h,
              ),
              activeIcon: Icon(
                Icons.newspaper,
                size: 24.h,
              ),
              label: 'News',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
