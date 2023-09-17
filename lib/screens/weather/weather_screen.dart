import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:remind_me/bloc/weather_bloc.dart';
import 'package:remind_me/data/response/app_response.dart';
import 'package:remind_me/data/response/status.dart';
import 'package:remind_me/models/weather_model.dart';
import 'package:remind_me/screens/weather/widgets/daily_forecast_widget.dart';
import 'package:remind_me/screens/weather/widgets/hourly_forecast_widget.dart';
import 'package:remind_me/styles/app_colors.dart';
import 'package:remind_me/styles/styles.dart';
import 'package:remind_me/widgets/general_error.dart';
import 'package:remind_me/widgets/general_loading.dart';
import 'package:remind_me/widgets/general_textfield.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().getWeather();
  }

  final locationNameController = TextEditingController();
  _showSearchLocation() async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Search Weather',
                style: subTitleText,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GeneralTextField(
                    removePrefixIconDivider: true,
                    textInputAction: TextInputAction.next,
                    keywordType: TextInputType.text,
                    prefixWidget: const Icon(Icons.search),
                    validate: (val) {},
                    controller: locationNameController,
                    hintText: 'Enter location eg. Nepal',
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: bodyText.copyWith(
                      color: AppColors.redColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<WeatherBloc>()
                        .getWeather(locationNameController.text);
                    Navigator.pop(context);
                    locationNameController.clear();
                  },
                  child: Text(
                    'Search',
                    style: bodyText.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    int currTemp = 30; // current temperature
    int maxTemp = 30; // today max temperature
    int minTemp = 2; // today min temperature
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.reminderBgColor,
        title: const Text(
          'Weather',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          GestureDetector(
            onTap: _showSearchLocation,
            child: Container(
              padding: EdgeInsets.only(right: 16.w),
              child: const FaIcon(
                FontAwesomeIcons.circlePlus,
                color: Colors.white,
              ),
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

                            //Map function is used to build row of each hourly forecast widget
                            Padding(
                              padding: EdgeInsets.all(size.width * 0.005),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: today.hours
                                      .map((e) => HourlyForecastWidget(
                                            time: DateFormat.Hm().format(
                                                DateTime.parse(
                                                    "${today.datetime}T${e.datetime}")), //hour
                                            temp: e.temp!.floor(), //temperature
                                            wind: e.windspeed!
                                                .floor(), //wind (km/h)
                                            rainChance: e.precipprob!
                                                .floor(), //rain chance (%)
                                            weatherIcon:
                                                getIcons(e.icon), //weather icon
                                            size: size,
                                            isDarkMode: isDarkMode,
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
                            //Map function is used to build column of each day forecast widget
                            Padding(
                              padding: EdgeInsets.all(size.width * 0.005),
                              child: Column(
                                children: state.data!.days
                                    .map((e) => DailyForecastWidget(
                                          time: DateTime.parse(e.datetime)
                                                      .toIso8601String()
                                                      .substring(0, 10) ==
                                                  DateTime.now()
                                                      .toIso8601String()
                                              ? "Today"
                                              : DateFormat.E().format(
                                                  DateTime.parse(
                                                      e.datetime)), //day
                                          minTemp: e.tempmin!
                                              .floor(), //min temperature
                                          maxTemp: e.tempmax!
                                              .floor(), //max temperature
                                          weatherIcon:
                                              getIcons(e.icon), //weather icon
                                          size: size,
                                          isDarkMode: isDarkMode,
                                        ))
                                    .toList(),
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
}
