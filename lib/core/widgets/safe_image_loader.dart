import 'dart:typed_data';

import 'package:ch5_practical/core/widgets/safe_memory_image_load.dart';
import 'package:ch5_practical/core/widgets/safe_network_image_widget.dart';
import 'package:flutter/material.dart';

class SafeImageLoader extends StatelessWidget {
  const SafeImageLoader({
    Key? key,
    this.imageUrl,
    this.imageSrcBytes,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String? imageUrl;
  final Uint8List? imageSrcBytes;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return (imageSrcBytes == null)
        ? SafeNetworkImageLoad(
            imgSource: imageUrl,
            width: width,
            height: height,
          )
        : SafeMemoryImageLoad(
            imageBytes: imageSrcBytes,
            width: width,
            height: height,
          );
  }
}
