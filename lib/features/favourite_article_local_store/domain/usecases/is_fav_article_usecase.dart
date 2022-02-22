import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/usecase_template.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/repositories/data_local_store_repository.dart';
import 'package:equatable/equatable.dart';

class IsFavArticle implements UseCase<ResultState, TitleParams> {
  final DataLocalStoreRepository _localStoreRepository;

  IsFavArticle(this._localStoreRepository);

  @override
  Future<ResultState> call(TitleParams params) {
    return _localStoreRepository.isFavourite(params.title);
  }
}

class TitleParams extends Equatable {
  final String title;

  const TitleParams(this.title);

  @override
  List<Object?> get props => [title];
}
