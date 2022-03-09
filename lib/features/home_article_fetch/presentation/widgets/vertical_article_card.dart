import 'dart:math' show Random;

import 'package:ch5_practical/core/models_and_entities/article_entity.dart';
import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/core/widgets/safe_network_image_widget.dart';
import 'package:flutter/material.dart';

class ArticlesVertical extends StatelessWidget {
  const ArticlesVertical(
    this.data, {
    Key? key,
    required this.imgHeight,
    required this.imgWidth,
    this.boxWidth,
    this.elevation,
    this.shadowColor,
  }) : super(key: key);

  final List<Article> data;
  final double imgHeight, imgWidth;
  final double? boxWidth, elevation;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        String _tag = Random().nextInt(1000).toString();
        return GestureDetector(
          onTap: () => handleArticleNavigation(
            <String, dynamic>{
              'data': data[index],
              'tag': _tag,
            },
          ),
          child: Hero(
            tag: _tag,
            child: Container(
              width: boxWidth,
              margin: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Material(
                elevation: elevation!,
                shadowColor: shadowColor!,
                type: MaterialType.card,
                child: Column(
                  children: [
                    SafeNetworkImageLoad(
                      imgSource: data[index].urlToImage,
                      width: imgWidth,
                      height: imgHeight,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data[index].source,
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              data[index].publishedAt,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          data[index].title,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(fontSize: 20),
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
    );
  }
}
