import 'package:remind_me/api/api_manager.dart';
import 'package:remind_me/data/app_urls.dart';
import 'package:remind_me/data/enum/request_type.dart';
import 'package:remind_me/models/news_model.dart';

class NewsApi {
  final _apiManager = ApiManager();
  Future<NewsModel> getNewsData() async {
    try {
      dynamic response = await _apiManager.request(
        url: AppUrl.newsApi,
        requestType: RequestType.get,
      );
      return NewsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
