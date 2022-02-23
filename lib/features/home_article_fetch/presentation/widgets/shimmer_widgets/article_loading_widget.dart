import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/news_horizontal_loading.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/news_vertical_loading.dart';
import 'package:flutter/material.dart';

class ArticleLoadingShimmer extends StatelessWidget {
  const ArticleLoadingShimmer({Key? key, this.showHalf = false})
      : super(key: key);
  final bool showHalf;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NewsVerticalLoading(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              NewsVerticalLoading(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ],
          ),
        ),
        if (!showHalf)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                NewsHorizontalLoading(
                  height: 140,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                const SizedBox(height: 16),
                NewsHorizontalLoading(
                  height: 140,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
