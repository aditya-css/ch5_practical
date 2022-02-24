import 'package:ch5_practical/core/models_and_entities/article_entity.dart';
import 'package:equatable/equatable.dart';

abstract class StarBlocEvent extends Equatable {
  const StarBlocEvent();

  @override
  List<Object> get props => [];
}

class FindStarred extends StarBlocEvent {
  final String title;

  const FindStarred(this.title);

  @override
  List<Object> get props => [title];
}

class ArticleStarred extends StarBlocEvent {
  final Article article;

  const ArticleStarred(this.article);

  @override
  List<Object> get props => [article];
}

class ArticleUnStarred extends StarBlocEvent {
  final int id;

  const ArticleUnStarred(this.id);

  @override
  List<Object> get props => [id];
}
