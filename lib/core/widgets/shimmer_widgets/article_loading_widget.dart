import 'package:ch5_practical/core/widgets/shimmer_widgets/article_detail_loading_shimmer.dart';
import 'package:ch5_practical/core/widgets/shimmer_widgets/favourite_article_loading_widget.dart';
import 'package:flutter/material.dart';

class ArticleLoadingShimmer extends StatelessWidget {
  const ArticleLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ArticleDetailsLoadingShimmer(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 350,
            child: FavouritesLoadingShimmer(
              scrollPhysics: const NeverScrollableScrollPhysics(),
              articleCount: 2,
              height: 140,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ArticleDetailsLoadingShimmer(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.4,
          ),
        ),
      ],
    );
  }
}
