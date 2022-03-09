import 'package:ch5_practical/core/image_paths.dart';
import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/usecase_template.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/usecases/article_fetch_usecase.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/usecases/category_fetch_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';

part 'data_fetch_store.g.dart';

class DataFetchStore = _DataFetchStore with _$DataFetchStore;

abstract class _DataFetchStore with Store {
  late final ArticleFetch _fetchArticles;
  late final CategoryFetch _fetchCategories;

  _DataFetchStore({
    required ArticleFetch articleFetch,
    required CategoryFetch categoryFetch,
  }) {
    _fetchArticles = articleFetch;
    _fetchCategories = categoryFetch;
  }

  Future<bool> get isConnected async =>
      await InternetConnectionChecker().hasConnection;

  @action
  ObservableFuture<ResultState> getArticles() =>
      ObservableFuture<ResultState>(_fetchArticles(NoParams()));

  @action
  ObservableFuture<ResultState> getCategories() =>
      ObservableFuture<ResultState>(
        _fetchCategories(
          const Params(ImagePath.categoryJsonSrc),
        ),
      );
}
