import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/shimmering_image_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/shimmering_text_widget.dart';
import 'package:flutter/material.dart';

class NewsVerticalLoading extends StatelessWidget {
  const NewsVerticalLoading({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageShimmer(height: width, width: width),
        const SizedBox(height: 8.0),
        SizedBox(
          height: height,
          width: width,
          child: const TextShimmer(),
        ),
      ],
    );
  }
}
