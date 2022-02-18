import 'package:ch5_practical/core/result_state_template.dart';

abstract class DataFetchRepository {
  Future<ResultState> getArticles();
  Future<ResultState> getCategories(String src);
}
