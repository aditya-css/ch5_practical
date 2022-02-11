import 'package:ch5_practical/networking/news_api_client.dart';
import 'package:ch5_practical/networking/news_chopper_client.dart';
import 'package:dio/dio.dart';

class ApiConst {
  //base
  static const String apiKey = '5377d5133c384339aa839c6bcdfe9d6f';
  static const String baseUrl = 'https://newsapi.org/v2/';

  //endpoints
  static const String indiaHeadlines = '/top-headlines?country=in';

  //client
  static NewsApiClient client = NewsApiClient(
    Dio(
      BaseOptions(
        headers: <String, dynamic>{'X-Api-Key': apiKey},
        baseUrl: baseUrl,
      ),
    ),
  );

  static NewsChopperClient chopperClient = NewsChopperClient.create();
}
