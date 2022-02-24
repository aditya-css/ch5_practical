import 'dart:math' show Random;

import 'package:ch5_practical/core/models_and_entities/article_entity.dart';
import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/core/widgets/article_horizontal_view.dart';
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
                child: ArticleViewHorizontal(
                  data[index],
                  imgHeight: imgHeight,
                  imgWidth: imgWidth,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
