import 'package:ch5_practical/networking/news_api_client.dart';
import 'package:dio/dio.dart';

//TODO: ask mentor where to put this base getters
//base
String get _apiKey => '5377d5133c384339aa839c6bcdfe9d6f';

String get _baseUrl => 'https://newsapi.org/v2/';

class ApiConst {
  //endpoints
  static const String indiaHeadlines = '/top-headlines?country=in';

  //TODO: ask mentor about having only a single client
  //client
  static NewsApiClient client = NewsApiClient(
    Dio(
      BaseOptions(
        headers: <String, dynamic>{'X-Api-Key': _apiKey},
        baseUrl: _baseUrl,
      ),
    ),
  );
}
