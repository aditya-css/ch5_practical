import 'package:bloc/bloc.dart';
import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/find_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/remove_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/save_fav_article_usecase.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/bloc/star_bloc_event.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/bloc/star_bloc_state.dart';

class StarBloc extends Bloc<StarBlocEvent, StarBlocState> {
  final FindFavArticle _find;
  final SaveFavArticle _save;
  final RemoveFavArticle _remove;

  StarBloc({
    required FindFavArticle isFavArticle,
    required SaveFavArticle saveFavArticle,
    required RemoveFavArticle removeFavArticle,
  })  : _find = isFavArticle,
        _save = saveFavArticle,
        _remove = removeFavArticle,
        super(const StarInitial()) {
    on<FindStarred>(_mapFindEventToState);
    on<ArticleStarred>(_mapStarEventToState);
    on<ArticleUnStarred>(_mapUnStarEventToState);
  }

  void _mapFindEventToState(
    FindStarred event,
    Emitter<StarBlocState> emit,
  ) async {
    emit(const StarLoading());
    final ResultState _result = await _find(TitleParams(event.title));
    if (_result is Success<num>) {
      emit(StarSuccess(_result.value));
    } else {
      emit(StarFailed((_result as Failure).value.message!));
    }
  }

  void _mapStarEventToState(
    ArticleStarred event,
    Emitter<StarBlocState> emit,
  ) async {
    emit(const StarLoading());
    final ResultState _result = await _save(ArticleParams(event.article));
    if (_result is Success<int>) {
      emit(StarSuccess(_result.value));
    } else {
      emit(StarFailed((_result as Failure).value.message!));
    }
  }

  void _mapUnStarEventToState(
    ArticleUnStarred event,
    Emitter<StarBlocState> emit,
  ) async {
    emit(const StarLoading());
    final ResultState _result = await _remove(Params(id: event.id));
    if (_result is Success) {
      emit(const StarSuccess(double.nan));
    } else {
      emit(StarFailed((_result as Failure).value.message!));
    }
  }
}
