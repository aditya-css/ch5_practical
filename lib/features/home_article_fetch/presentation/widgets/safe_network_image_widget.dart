import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/error_card_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/shimmering_image_widget.dart';
import 'package:flutter/material.dart';

class SafeImageLoad extends StatelessWidget {
  const SafeImageLoad({
    Key? key,
    this.src,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String? src;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return (src == null)
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
        : Image.network(
            src!,
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
