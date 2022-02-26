import 'package:ch5_practical/core/widgets/error_card_widget.dart';
import 'package:ch5_practical/core/widgets/no_image_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
        : FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imgSource!,
            height: height,
            width: width,
            fit: BoxFit.cover,
            imageErrorBuilder: (_, __, ___) {
              return Container(
                width: width,
                height: height,
                color: Theme.of(context).colorScheme.error,
                child: const ErrorCard(),
              );
            },
            placeholderErrorBuilder: (_, __, ___) {
              return SizedBox(
                height: height,
                width: width,
                child: const NoImageFound(),
              );
            },
          );
  }
}
