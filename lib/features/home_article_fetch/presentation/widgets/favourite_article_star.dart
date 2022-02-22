import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/bloc/star_bloc.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/bloc/star_bloc_event.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/bloc/star_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteArticleStar extends StatefulWidget {
  const FavouriteArticleStar({Key? key, required this.article})
      : super(key: key);
  final Article article;

  @override
  _FavouriteArticleStarState createState() => _FavouriteArticleStarState();
}

class _FavouriteArticleStarState extends State<FavouriteArticleStar> {
  @override
  void didChangeDependencies() {
    context.read<StarBloc>().add(FindStarred(widget.article.title));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StarBloc, StarBlocState>(
      builder: (BuildContext context, StarBlocState state) {
        if (state is StarFailed) {
          return IconButton(
            icon: const Icon(Icons.error),
            onPressed: () {},
            tooltip: state.message,
          );
        }
        if (state is StarSuccess) {
          final bool _isNotFav = state.index.isNaN;
          return IconButton(
            icon: Icon(
              _isNotFav ? Icons.star_rate_outlined : Icons.star_rate_rounded,
            ),
            onPressed: () {
              _isNotFav
                  ? context.read<StarBloc>().add(
                        ArticleStarred(widget.article),
                      )
                  : context.read<StarBloc>().add(
                        ArticleUnStarred(
                          widget.article.id ?? state.index as int,
                        ),
                      );
            },
          );
        }
        return const Padding(
          padding: EdgeInsets.all(4.0),
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
