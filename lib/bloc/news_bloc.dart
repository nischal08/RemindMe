import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remind_me/api/news_api.dart';
import 'package:remind_me/data/response/app_response.dart';
import 'package:remind_me/models/news_model.dart';
import 'package:remind_me/repository/database_repository.dart';

class NewsBloc extends Cubit<AppResponse<NewsModel>> {
  NewsBloc() : super(AppResponse.loading());
  final myRepo = NewsApi();

  Future<void> getNews() async {
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
      await myRepo.getNewsData().then((NewsModel value) {
        DatabaseRepository.addNewsData(value.toJson());
        emit(AppResponse.completed(value));
      });
    } else {
      Map? jsonData = await DatabaseRepository.getNewsData();
      if (jsonData != null) {
        late Map<String, dynamic> newData = {};
        jsonData.forEach(
          (key, value) {
            newData[key] = value;
          },
        );
        emit(
          AppResponse.completed(
            NewsModel.fromJson(newData),
          ),
        );
      } else {
        throw "Server Error!";
      }
    }
  }
}
