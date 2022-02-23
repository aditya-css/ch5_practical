import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';

abstract class DataLocalStoreRepository {
  Future<ResultState> getAllFavourites();
  Future<ResultState> saveFavourite(Article favArticle);
  Future<ResultState> findFavourite(String articleTitle);
  Future<ResultState> removeFavourite(int id);
  Future<ResultState> deleteAllFavourites();
}
