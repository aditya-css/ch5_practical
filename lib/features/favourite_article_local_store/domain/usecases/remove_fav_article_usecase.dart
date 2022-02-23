import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/usecase_template.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/repositories/data_local_store_repository.dart';
import 'package:equatable/equatable.dart';

class RemoveFavArticle implements UseCase<ResultState, Params> {
  final DataLocalStoreRepository _localStoreRepository;

  RemoveFavArticle(this._localStoreRepository);

  @override
  Future<ResultState> call(Params params) {
    return _localStoreRepository.removeFavourite(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
