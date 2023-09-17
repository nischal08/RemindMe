import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:remind_me/bloc/weather_bloc.dart';
import 'package:remind_me/data/response/app_response.dart';
import 'package:remind_me/data/response/status.dart';
import 'package:remind_me/models/weather_model.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/styles/styles.dart';
import 'package:remind_me/widgets/general_error.dart';
import 'package:remind_me/widgets/general_loading.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WeatherBloc>().getWeather();
  }

  @override
  Widget build(BuildContext context) {
    // String cityName = "Kathmandu"; //city name
    int currTemp = 30; // current temperature
    int maxTemp = 30; // today max temperature
    int minTemp = 2; // today min temperature
    Size size = MediaQuery.of(context).size;
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isDarkMode = brightness == Brightness.dark;
    bool isDarkMode = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.reminderBgColor,
        title: Text(
          'Weather',
          style: bodyText.copyWith(
              color: Colors.white, fontSize: 16.h, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 16.w),
            child: const FaIcon(
              FontAwesomeIcons.circlePlus,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: BlocBuilder<WeatherBloc, AppResponse<WeatherModel>>(
          builder: (_, state) {
        switch (state.status) {
          case Status.LOADING:
            return const GeneralLoading();
          case Status.ERROR:
            return const GeneralError();
          case Status.COMPLETED:
            final today = state.data!.days.first;
            currTemp = today.temp!.floor(); // current temperature
            maxTemp = today.tempmax!.floor(); // today max temperature
            minTemp = today.tempmin!.floor();
            return Container(
              // height: size.height,
              // width: size.height,
              decoration: BoxDecoration(
                color: AppColors.reminderBgColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.03,
                      ),
                      child: Align(
                        child: Text(
                          state.data!.timezone.replaceAll("Asia/", ""),
                          style: bodyText.copyWith(
                            color: Colors.white,
                            fontSize: size.height * 0.055,
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
                            color: Colors.white,
                            fontSize: size.height * 0.13,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.25),
                      child: const Divider(
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                      ),
                      child: Align(
                        child: Text(
                          today.conditions, // weather
                          style: bodyText.copyWith(
                            color: Colors.white,
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
                              color: Colors.white54,
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
                              color: Colors.white,
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
                                  children: today.hours
                                      .map((e) => buildForecastToday(
                                            DateFormat.Hm().format(DateTime.parse(
                                                "${today.datetime}T${e.datetime}")), //hour
                                            e.temp!.floor(), //temperature
                                            e.windspeed!.floor(), //wind (km/h)
                                            e.precipprob!
                                                .floor(), //rain chance (%)
                                            getIcons(e.icon), //weather icon
                                            size,
                                            isDarkMode,
                                          ))
                                      .toList(),
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
                            const Divider(
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.all(size.width * 0.005),
                              child: Column(
                                children: [
                                  ...state.data!.days
                                      .map((e) => buildSevenDayForecast(
                                            DateTime.parse(e.datetime)
                                                        .toIso8601String()
                                                        .substring(0, 10) ==
                                                    DateTime.now()
                                                        .toIso8601String()
                                                ? "Today"
                                                : DateFormat.E().format(
                                                    DateTime.parse(
                                                        e.datetime)), //day
                                            e.tempmin!
                                                .floor(), //min temperature
                                            e.tempmax!
                                                .floor(), //max temperature
                                            getIcons(e.icon), //weather icon
                                            size,
                                            isDarkMode,
                                          ))
                                      .toList(),
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
                                    FontAwesomeIcons.cloud,
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
            );
        }
      }),
    );
  }

  IconData getIcons(icon) {
    switch (icon) {
      case "rain":
        return FontAwesomeIcons.cloudRain;
      case "partly-cloudy-day":
        return FontAwesomeIcons.cloud;
      case "partly-cloudy-night":
        return FontAwesomeIcons.cloud;
      case "sunny-day":
        return FontAwesomeIcons.cloud;
      case "sunny":
        return FontAwesomeIcons.cloud;
      case "cloudy-day":
        return FontAwesomeIcons.cloud;
      case "cloudy-night":
        return FontAwesomeIcons.cloud;
      default:
        return FontAwesomeIcons.sun;
    }
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
