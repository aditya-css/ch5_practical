import 'package:ch5_practical/core/widgets/error_card_widget.dart';
import 'package:ch5_practical/core/widgets/no_image_found_widget.dart';
import 'package:ch5_practical/core/widgets/shimmer_widgets/shimmering_image_widget.dart';
import 'package:flutter/material.dart';

class SafeNetworkImageLoad extends StatelessWidget {
  const SafeNetworkImageLoad({
    Key? key,
    this.imgSource,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String? imgSource;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return (imgSource == null)
        ? SizedBox(
            height: height,
            width: width,
            child: const NoImageFound(),
          )
        : Image.network(
            imgSource!,
            fit: BoxFit.cover,
            width: width,
            height: height,
            loadingBuilder: (_, Widget child, ImageChunkEvent? progress) {
              if (progress == null) return child;
              return ImageShimmer(height: height, width: width);
            },
            errorBuilder: (_, __, ___) {
              return Container(
                width: width,
                height: height,
                color: Theme.of(context).colorScheme.error,
                child: const ErrorCard(),
              );
            },
          );
  }
}
