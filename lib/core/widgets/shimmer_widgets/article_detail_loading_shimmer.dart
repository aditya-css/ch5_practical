import 'package:ch5_practical/core/widgets/shimmer_widgets/news_vertical_loading.dart';
import 'package:flutter/material.dart';

class ArticleDetailsLoadingShimmer extends StatelessWidget {
  const ArticleDetailsLoadingShimmer({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NewsVerticalLoading(
          height: height,
          width: width,
        ),
        NewsVerticalLoading(
          height: height,
          width: width,
        ),
      ],
    );
  }
}
