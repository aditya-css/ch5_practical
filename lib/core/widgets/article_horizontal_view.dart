import 'package:ch5_practical/core/models_and_entities/article_entity.dart';
import 'package:ch5_practical/core/widgets/safe_image_loader.dart';
import 'package:flutter/material.dart';

class ArticleViewHorizontal extends StatelessWidget {
  const ArticleViewHorizontal(
    this.article, {
    Key? key,
    required this.imgHeight,
    required this.imgWidth,
    this.elevation = 0.0,
  }) : super(key: key);

  final Article article;
  final double elevation;
  final double imgHeight, imgWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      elevation: elevation,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeImageLoader(
            imageUrl: article.urlToImage,
            imageSrcBytes: article.imgBytes,
            width: imgWidth,
            height: imgHeight,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: Text(
                      article.publishedAt,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Text(
                    article.description,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
