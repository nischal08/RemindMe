import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/styles/styles.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    String cityName = "Kathmandu"; //city name
    int currTemp = 30; // current temperature
    int maxTemp = 30; // today max temperature
    int minTemp = 2; // today min temperature
    Size size = MediaQuery.of(context).size;
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isDarkMode = brightness == Brightness.dark;
    bool isDarkMode = true;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: kToolbarHeight),
        height: size.height,
        width: size.height,
        decoration: BoxDecoration(
          color: AppColors.reminderBgColor,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Weather',
                            style: bodyText.copyWith(
                                color: Colors.white,
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.circlePlus,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                    ),
                    child: Align(
                      child: Text(
                        cityName,
                        style: bodyText.copyWith(
                          color: Colors.white,
                          fontSize: size.height * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.005,
                    ),
                    child: Align(
                      child: Text(
                        'Today', //day
                        style: bodyText.copyWith(
                          color: Colors.white54,
                          fontSize: size.height * 0.035,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                    ),
                    child: Align(
                      child: Text(
                        '$currTemp˚C', //curent temperature
                        style: bodyText.copyWith(
                          color: currTemp <= 0
                              ? Colors.blue
                              : currTemp > 0 && currTemp <= 15
                                  ? Colors.white
                                  : currTemp > 15 && currTemp < 30
                                      ? Colors.deepPurple
                                      : Colors.white,
                          fontSize: size.height * 0.13,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.25),
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.005,
                    ),
                    child: Align(
                      child: Text(
                        'Sunny', // weather
                        style: bodyText.copyWith(
                          color: Colors.white54,
                          fontSize: size.height * 0.03,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                      bottom: size.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$minTemp˚C', // min temperature
                          style: bodyText.copyWith(
                            color: minTemp <= 0
                                ? Colors.blue
                                : minTemp > 0 && minTemp <= 15
                                    ? Colors.white
                                    : minTemp > 15 && minTemp < 30
                                        ? Colors.deepPurple
                                        : Colors.white,
                            fontSize: size.height * 0.03,
                          ),
                        ),
                        Text(
                          '/',
                          style: bodyText.copyWith(
                            color: Colors.white54,
                            fontSize: size.height * 0.03,
                          ),
                        ),
                        Text(
                          '$maxTemp˚C', //max temperature
                          style: bodyText.copyWith(
                            color: maxTemp <= 0
                                ? Colors.blue
                                : maxTemp > 0 && maxTemp <= 15
                                    ? Colors.white
                                    : maxTemp > 15 && maxTemp < 30
                                        ? Colors.deepPurple
                                        : Colors.white,
                            fontSize: size.height * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white.withOpacity(0.05),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.01,
                                left: size.width * 0.03,
                              ),
                              child: Text(
                                'Forecast for today',
                                style: bodyText.copyWith(
                                  color: Colors.white,
                                  fontSize: size.height * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(size.width * 0.005),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  //TODO: change weather forecast from local to api get
                                  buildForecastToday(
                                    "Now", //hour
                                    currTemp, //temperature
                                    20, //wind (km/h)
                                    0, //rain chance (%)
                                    FontAwesomeIcons.sun, //weather icon
                                    size,
                                    isDarkMode,
                                  ),
                                  buildForecastToday(
                                    "15:00",
                                    1,
                                    10,
                                    40,
                                    FontAwesomeIcons.cloud,
                                    size,
                                    isDarkMode,
                                  ),
                                  buildForecastToday(
                                    "16:00",
                                    0,
                                    25,
                                    80,
                                    FontAwesomeIcons.cloudRain,
                                    size,
                                    isDarkMode,
                                  ),
                                  buildForecastToday(
                                    "17:00",
                                    -2,
                                    28,
                                    60,
                                    FontAwesomeIcons.snowflake,
                                    size,
                                    isDarkMode,
                                  ),
                                  buildForecastToday(
                                    "18:00",
                                    -5,
                                    13,
                                    40,
                                    FontAwesomeIcons.cloudMoon,
                                    size,
                                    isDarkMode,
                                  ),
                                  buildForecastToday(
                                    "19:00",
                                    -8,
                                    9,
                                    60,
                                    FontAwesomeIcons.snowflake,
                                    size,
                                    isDarkMode,
                                  ),
                                  buildForecastToday(
                                    "20:00",
                                    -13,
                                    25,
                                    50,
                                    FontAwesomeIcons.snowflake,
                                    size,
                                    isDarkMode,
                                  ),
                                  buildForecastToday(
                                    "21:00",
                                    -14,
                                    12,
                                    40,
                                    FontAwesomeIcons.cloudMoon,
                                    size,
                                    isDarkMode,
                                  ),
                                  buildForecastToday(
                                    "22:00",
                                    -15,
                                    1,
                                    30,
                                    FontAwesomeIcons.moon,
                                    size,
                                    isDarkMode,
                                  ),
                                  buildForecastToday(
                                    "23:00",
                                    -15,
                                    15,
                                    20,
                                    FontAwesomeIcons.moon,
                                    size,
                                    isDarkMode,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.02,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white.withOpacity(0.05),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.03,
                              ),
                              child: Text(
                                '7-day forecast',
                                style: bodyText.copyWith(
                                  color: Colors.white,
                                  fontSize: size.height * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.all(size.width * 0.005),
                            child: Column(
                              children: [
                                //TODO: change weather forecast from local to api get
                                buildSevenDayForecast(
                                  "Today", //day
                                  minTemp, //min temperature
                                  maxTemp, //max temperature
                                  FontAwesomeIcons.cloud, //weather icon
                                  size,
                                  isDarkMode,
                                ),
                                buildSevenDayForecast(
                                  "Wed",
                                  -5,
                                  5,
                                  FontAwesomeIcons.sun,
                                  size,
                                  isDarkMode,
                                ),
                                buildSevenDayForecast(
                                  "Thu",
                                  -2,
                                  7,
                                  FontAwesomeIcons.cloudRain,
                                  size,
                                  isDarkMode,
                                ),
                                buildSevenDayForecast(
                                  "Fri",
                                  3,
                                  10,
                                  FontAwesomeIcons.sun,
                                  size,
                                  isDarkMode,
                                ),
                                buildSevenDayForecast(
                                  "San",
                                  5,
                                  12,
                                  FontAwesomeIcons.sun,
                                  size,
                                  isDarkMode,
                                ),
                                buildSevenDayForecast(
                                  "Sun",
                                  4,
                                  7,
                                  FontAwesomeIcons.cloud,
                                  size,
                                  isDarkMode,
                                ),
                                buildSevenDayForecast(
                                  "Mon",
                                  -2,
                                  1,
                                  FontAwesomeIcons.snowflake,
                                  size,
                                  isDarkMode,
                                ),
                                buildSevenDayForecast(
                                  "Tues",
                                  0,
                                  3,
                                  FontAwesomeIcons.cloudRain,
                                  size,
                                  isDarkMode,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildForecastToday(String time, int temp, int wind, int rainChance,
      IconData weatherIcon, size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.025),
      child: Column(
        children: [
          Text(
            time,
            style: bodyText.copyWith(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.02,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.005,
                ),
                child: FaIcon(
                  weatherIcon,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$temp˚C',
            style: bodyText.copyWith(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.025,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: FaIcon(
                  FontAwesomeIcons.wind,
                  color: Colors.white,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$wind km/h',
            style: bodyText.copyWith(
              color: Colors.white60,
              fontSize: size.height * 0.02,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: FaIcon(
                  FontAwesomeIcons.umbrella,
                  color: Colors.white,
                  size: size.height * 0.03,
                ),
              ),
            ],
          ),
          Text(
            '$rainChance %',
            style: bodyText.copyWith(
              color: Colors.white60,
              fontSize: size.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSevenDayForecast(String time, int minTemp, int maxTemp,
      IconData weatherIcon, size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(
        size.height * 0.005,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: Text(
                  time,
                  style: bodyText.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: size.height * 0.025,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.25,
                ),
                child: FaIcon(
                  weatherIcon,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: size.height * 0.03,
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.15,
                  ),
                  child: Text(
                    '$minTemp˚C',
                    style: bodyText.copyWith(
                      color: isDarkMode ? Colors.white38 : Colors.black38,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: Text(
                    '$maxTemp˚C',
                    style: bodyText.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
