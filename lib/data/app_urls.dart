class AppUrl {
  // static const String weatherApiKey = "Z4CFUXYJY4EU5RFJR9MLSDAUG";
  static const String weatherApiKey = "7JWQMV9WC5JJBUQF22L83ERCB";
  static const String newsApiKey = "e8ac89412f24429fbf8eff84afa682a5";
  static const String newsApi =
      "https://newsapi.org/v2/everything?q=tech&sortBy=popularity&apiKey=$newsApiKey";
  static const String weatherApiUrl =
      "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/[latitude],[longitude]?unitGroup=metric&key=$weatherApiKey&contentType=json";
}
