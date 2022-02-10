import 'dart:math' show Random;

import 'package:ch5_practical/custom_error_card.dart';
import 'package:ch5_practical/extensions.dart';
import 'package:ch5_practical/loading_image_widget.dart';
import 'package:ch5_practical/networking/models/article_model.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

class ArticlesHorizontal extends StatelessWidget {
  const ArticlesHorizontal(
    this.data, {
    Key? key,
    required this.length,
    required this.imgHeight,
    required this.imgWidth,
  }) : super(key: key);

  final double imgHeight, imgWidth;
  final List<Article> data;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        length,
        (index) {
          String _tag = Random().nextInt(1000).toString();
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: GestureDetector(
              onTap: () => handleArticleNavigation(
                <String, dynamic>{
                  'data': data[index],
                  'tag': _tag,
                },
              ),
              child: Hero(
                tag: _tag,
                child: Material(
                  type: MaterialType.transparency,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        data[index].urlToImage,
                        fit: BoxFit.cover,
                        width: imgWidth,
                        height: imgHeight,
                        loadingBuilder:
                            (_, Widget child, ImageChunkEvent? progress) {
                          if (progress == null) return child;
                          return LoadingImage(
                              width: imgWidth, height: imgHeight);
                        },
                        errorBuilder: (_, __, ___) {
                          return Container(
                            width: imgWidth,
                            height: imgHeight,
                            color: Theme.of(context).colorScheme.error,
                            child: const ErrorCard(),
                          );
                        },
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index].title,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontSize: 18),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                TimeAgo(data[index].publishedAt).calculate,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            Text(
                              data[index].description,
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
