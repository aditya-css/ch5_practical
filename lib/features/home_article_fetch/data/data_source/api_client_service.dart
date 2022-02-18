import 'package:ch5_practical/core/api_const.dart';
import 'package:ch5_practical/features/home_article_fetch/data/models/api_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client_service.g.dart';

@RestApi()
abstract class ApiClientService {
  factory ApiClientService(Dio dio) = _ApiClientService;

  @GET(ApiConst.kIndiaHeadlines)
  Future<HttpResponse<ApiResponse>> getTopArticles();
}
