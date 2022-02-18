import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/usecase_template.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/repositories/data_fetch_repository.dart';

class ArticleFetch implements UseCase<ResultState, NoParams> {
  final DataFetchRepository _dataFetchRepo;

  ArticleFetch(this._dataFetchRepo);

  @override
  Future<ResultState> call(NoParams params) {
    return _dataFetchRepo.getArticles();
  }
}
