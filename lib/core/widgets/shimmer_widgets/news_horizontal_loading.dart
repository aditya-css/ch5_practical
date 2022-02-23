import 'package:ch5_practical/core/widgets/shimmer_widgets/shimmering_image_widget.dart';
import 'package:ch5_practical/core/widgets/shimmer_widgets/shimmering_text_widget.dart';
import 'package:flutter/material.dart';

class NewsHorizontalLoading extends StatelessWidget {
  const NewsHorizontalLoading({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageShimmer(height: width, width: width),
        const SizedBox(width: 8.0),
        SizedBox(
          height: height,
          width: width,
          child: Column(
            children: const [
              TextShimmer(),
              SizedBox(height: 16.0),
              TextShimmer(),
              SizedBox(height: 16.0),
              TextShimmer(),
            ],
          ),
        ),
      ],
    );
  }
}
