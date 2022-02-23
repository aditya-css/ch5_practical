import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/usecase_template.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/repositories/data_local_store_repository.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

class SaveFavArticle implements UseCase<ResultState, ArticleParams> {
  final DataLocalStoreRepository _localStoreRepository;

  SaveFavArticle(this._localStoreRepository);

  @override
  Future<ResultState> call(ArticleParams params) {
    return _localStoreRepository.saveFavourite(params.article);
  }
}

class ArticleParams extends Equatable {
  final Article article;

  const ArticleParams(this.article);

  @override
  List<Object?> get props => [article];
}
