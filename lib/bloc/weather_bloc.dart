import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:remind_me/api/weather_api.dart';
import 'package:remind_me/data/app_urls.dart';
import 'package:remind_me/data/response/app_response.dart';
import 'package:remind_me/models/weather_model.dart';
import 'package:remind_me/repository/database_repository.dart';

class WeatherBloc extends Cubit<AppResponse<WeatherModel>> {
  WeatherBloc() : super(AppResponse.loading());

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeather([String? locationName]) async {
    emit(AppResponse.loading());
    late bool isOnline;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }

    if (isOnline) {
      final myRepo = WeatherApi();
      double latitude;
      double longitude;
      Position position = await getUserCurrentLocation();
      latitude = position.latitude;
      longitude = position.longitude;
      final String url = AppUrl.weatherApiUrl
          .replaceAll("[latitude]", latitude.toString())
          .replaceAll("[longitude]", longitude.toString());
      log(url);
      myRepo.getWeatherData(url).then((WeatherModel value) {
        DatabaseRepository.addWeatherData(value.toJson());
        emit(AppResponse.completed(value));
      });
    } else {
      Map? jsonData = await DatabaseRepository.getWeatherData();
      if (jsonData != null) {
        late Map<String, dynamic> newData = {};
        jsonData.forEach(
          (key, value) {
            newData[key] = value;
          },
        );
        emit(
          AppResponse.completed(
            WeatherModel.fromJson(newData),
          ),
        );
      } else {
        throw "Server Error!";
      }
    }
  }
}
