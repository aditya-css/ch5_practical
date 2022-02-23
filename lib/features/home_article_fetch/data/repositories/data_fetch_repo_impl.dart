import 'dart:io';

import 'package:ch5_practical/core/models_and_entities/article_entity.dart';
import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/features/home_article_fetch/data/data_source/api_client_service.dart';
import 'package:ch5_practical/features/home_article_fetch/data/data_source/local_json_service.dart';
import 'package:ch5_practical/features/home_article_fetch/data/models/api_response_model.dart';
import 'package:ch5_practical/features/home_article_fetch/data/models/categories_model.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/categories_entity.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/repositories/data_fetch_repository.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

class DataFetchRepositoryImpl implements DataFetchRepository {
  final ApiClientService _apiClientService;
  final LocalJsonFetchService _localJsonService;

  DataFetchRepositoryImpl({
    required ApiClientService apiClient,
    required LocalJsonFetchService localJsonClient,
  })  : _apiClientService = apiClient,
        _localJsonService = localJsonClient;

  @override
  Future<ResultState> getCategories(String source) async {
    try {
      final _jsonResult = await _localJsonService.getLocalCategories(source);
      Categories _categories = CategoriesModel.fromJson(_jsonResult);
      return Success<Categories>(_categories);
    } catch (e) {
      return Failure(ApiException(message: e.toString()));
    }
  }

  @override
  Future<ResultState> getArticles() async {
    try {
      final HttpResponse<ApiResponse> _response =
          await _apiClientService.getTopArticles();
      if (_response.response.statusCode == HttpStatus.ok) {
        return Success<List<Article>>(
          _response.data.articles!,
        );
      }
      return Failure(
        ApiException(
          code: _response.response.statusCode!,
          message: _response.response.statusMessage!,
        ),
      );
    } on DioError catch (e) {
      throw Failure(
        ApiException(
          code: e.response?.statusCode,
          message: e.response?.statusMessage,
        ),
      );
    }
  }
}
