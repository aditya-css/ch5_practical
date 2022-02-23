import 'dart:typed_data';

import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/error_card_widget.dart';
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
            child: Material(
              type: MaterialType.card,
              color: Colors.grey.shade300,
              child: Center(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.image_not_supported),
                      SizedBox(height: 8.0),
                      Text(
                        'No Image Found.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
