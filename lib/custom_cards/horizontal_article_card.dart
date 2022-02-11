import 'dart:math' show Random;

import 'package:ch5_practical/article_page_widgets/safe_network_image_widget.dart';
import 'package:ch5_practical/extensions.dart';
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
                  type: MaterialType.card,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeImageLoad(
                        src: data[index].urlToImage,
                        width: imgWidth,
                        height: imgHeight,
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].title ?? 'No Title Found.',
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(fontSize: 18),
                              ),
                              if (data[index].publishedAt != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    (data[index].publishedAt == null)
                                        ? 'no date'
                                        : TimeAgo(data[index].publishedAt!)
                                            .calculate,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              Text(
                                data[index].description ??
                                    'No Description Found.',
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
