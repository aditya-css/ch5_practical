import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/shimmer_effect_widget.dart';
import 'package:flutter/material.dart';

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }
}
