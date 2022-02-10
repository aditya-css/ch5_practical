import 'package:ch5_practical/networking/api_constants.dart';
import 'package:ch5_practical/networking/models/api_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_client.g.dart';

@RestApi()
abstract class NewsApiClient {
  factory NewsApiClient(Dio dio, {String? baseUrl}) = _NewsApiClient;

  @GET(ApiConst.indiaHeadlines)
  Future<ApiResponse> getTopArticles();
}
