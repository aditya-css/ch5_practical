import 'package:ch5_practical/core/widgets/shimmer_widgets/news_horizontal_loading.dart';
import 'package:flutter/material.dart';

class FavouritesLoadingShimmer extends StatelessWidget {
  const FavouritesLoadingShimmer({
    Key? key,
    required this.articleCount,
    required this.height,
    required this.width,
  }) : super(key: key);

  final int articleCount;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articleCount,
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemBuilder: (_, __) => NewsHorizontalLoading(
        height: height,
        width: width,
      ),
    );
  }
}
