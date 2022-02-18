import 'package:ch5_practical/features/home_article_fetch/data/data_source/api_client_service.dart';
import 'package:ch5_practical/features/home_article_fetch/data/data_source/local_json_service.dart';
import 'package:dio/dio.dart';

class ApiConst {
  //base
  static const String kApiKey = '5377d5133c384339aa839c6bcdfe9d6f';
  static const String kBaseUrl = 'https://newsapi.org/v2/';

  //endpoints
  static const String kIndiaHeadlines = '/top-headlines?country=in';

  //client
  static ApiClientService client = ApiClientService(
    Dio(
      BaseOptions(
        headers: const <String, String>{'X-Api-Key': kApiKey},
        baseUrl: kBaseUrl,
      ),
    ),
  );

  static LocalJsonFetchService localClient = LocalJsonFetchService();
}
