import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:remind_me/api/weather_api.dart';
import 'package:remind_me/data/app_urls.dart';
import 'package:remind_me/data/response/app_response.dart';
import 'package:remind_me/models/weather_model.dart';

class WeatherBloc extends Cubit<AppResponse<WeatherModel>> {
  WeatherBloc() : super(AppResponse.loading());

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeather([String? locationName]) async {
    final myRepo = WeatherApi();
    emit(AppResponse.loading());
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
      emit(AppResponse.completed(value));
    });
  }
}
