import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/usecase_template.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/repositories/data_fetch_repository.dart';
import 'package:equatable/equatable.dart';

class CategoryFetch implements UseCase<ResultState, Params> {
  final DataFetchRepository _dataFetchRepo;

  CategoryFetch(this._dataFetchRepo);

  @override
  Future<ResultState> call(Params param) {
    return _dataFetchRepo.getCategories(param.src);
  }
}

class Params extends Equatable {
  final String src;

  const Params(this.src);

  @override
  List<Object?> get props => [src];
}
