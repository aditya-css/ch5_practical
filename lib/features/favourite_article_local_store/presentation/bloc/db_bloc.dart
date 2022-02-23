import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/usecase_template.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/delete_all_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/get_all_fav_articles_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/remove_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc_event.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc_state.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/bloc/star_bloc.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/bloc/star_bloc_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final GetAllFavArticles _getAll;
  final DeleteAllFavArticles _deleteAll;
  final RemoveFavArticle _remove;

  final StarBloc _starBloc;

  late final StreamSubscription _favouriteStream;

  DatabaseBloc({
    required GetAllFavArticles getAllFavArticles,
    required DeleteAllFavArticles deleteAllFavArticles,
    required RemoveFavArticle removeFavArticle,
    required StarBloc starBloc,
  })  : _getAll = getAllFavArticles,
        _deleteAll = deleteAllFavArticles,
        _remove = removeFavArticle,
        _starBloc = starBloc,
        super(const Initial()) {
    on<GetAllFavourites>(_mapGetAllEventToState);
    on<DeleteAllFavourites>(_mapDeleteAllEventToState);
    on<RemoveFavourite>(_mapRemoveEventToState);
    _favouriteStream = _starBloc.stream.listen((starState) {
      if (starState is StarSuccess) {
        add(const GetAllFavourites());
      }
    });
  }

  @override
  Future<void> close() {
    _favouriteStream.cancel();
    return super.close();
  }

  void _mapGetAllEventToState(
    GetAllFavourites event,
    Emitter<DatabaseState> emit,
  ) async {
    emit(const Loading());
    final ResultState _result = await _getAll(NoParams());
    if (_result is Success<List<Article>>) {
      emit(Complete<List<Article>>(_result.value));
    } else {
      emit(
        Failed(
          exclaim: 'Uh-Oh',
          title: 'No Favourite Articles.',
          message: (_result as Failure).value.message!,
        ),
      );
    }
  }

  void _mapDeleteAllEventToState(
    DeleteAllFavourites event,
    Emitter<DatabaseState> emit,
  ) async {
    emit(const Loading());
    final ResultState _result = await _deleteAll(NoParams());
    if (_result is Success) {
      emit(const Initial());
    } else {
      emit(
        Failed(
          exclaim: 'Uh-Oh',
          title: 'Failed to delete articles.',
          message: (_result as Failure).value.message!,
        ),
      );
    }
  }

  void _mapRemoveEventToState(
    RemoveFavourite event,
    Emitter<DatabaseState> emit,
  ) async {
    emit(const Loading());
    final ResultState _result = await _remove(Params(id: event.id));
    if (_result is Success) {
      emit(const Initial());
    } else {
      emit(Failed(message: (_result as Failure).value.message!));
    }
  }
}
