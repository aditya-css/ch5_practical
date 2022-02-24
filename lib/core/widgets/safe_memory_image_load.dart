import 'dart:typed_data';

import 'package:ch5_practical/core/widgets/error_card_widget.dart';
import 'package:ch5_practical/core/widgets/no_image_found_widget.dart';
import 'package:flutter/material.dart';

class SafeMemoryImageLoad extends StatelessWidget {
  const SafeMemoryImageLoad({
    Key? key,
    required this.imageBytes,
    required this.height,
    required this.width,
  }) : super(key: key);

  final Uint8List? imageBytes;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return (imageBytes == null)
        ? SizedBox(
            height: height,
            width: width,
            child: const NoImageFound(),
          )
        : Image.memory(
            imageBytes!,
            fit: BoxFit.cover,
            height: height,
            width: width,
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
