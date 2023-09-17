import 'package:remind_me/api/api_manager.dart';
import 'package:remind_me/data/enum/request_type.dart';
import 'package:remind_me/models/weather_model.dart';

import '/data/app_urls.dart';

class WeatherApi {
  final _apiManager = ApiManager();
  Future<WeatherModel> getDatingPerferencesInfo(url) async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.weatherApiUrl,
        requestType: RequestType.post,
      );
      return WeatherModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Future<dynamic> postProfileCreateData(BuildContext context) async {
  //   try {
  //     Map body = context.read<ProfileCreationBloc>().state.toJson();
  //     log(body.toString());
  //     dynamic response = await _apiManager.request(
  //       url: AppUrl.postProfileCreateUrl,
  //       requestType: RequestType.postWithToken,
  //       parameter: body,
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
