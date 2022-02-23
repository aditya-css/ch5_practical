import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/usecase_template.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/repositories/data_local_store_repository.dart';

class GetAllFavArticles implements UseCase<ResultState, NoParams> {
  final DataLocalStoreRepository _localStoreRepository;

  GetAllFavArticles(this._localStoreRepository);

  @override
  Future<ResultState> call(NoParams params) {
    return _localStoreRepository.getAllFavourites();
  }
}
