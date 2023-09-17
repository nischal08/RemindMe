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
    //This is logic for checking internet and retreiving the stored data in database as well as api calling when there is internet
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
        emit(
          AppResponse.completed(
            NewsModel.fromJson(jsonData),
          ),
        );
      } else {
        throw "Server Error!";
      }
    }
  }
}
