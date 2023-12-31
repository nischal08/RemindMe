import 'package:remind_me/api/api_manager.dart';
import 'package:remind_me/data/enum/request_type.dart';
import 'package:remind_me/models/weather_model.dart';

class WeatherApi {
  final _apiManager = ApiManager();
  Future<WeatherModel> getWeatherData(url) async {
    try {
      dynamic response = await _apiManager.request(
        url: url,
        requestType: RequestType.get,
      );
      return WeatherModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}
