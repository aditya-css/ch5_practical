import 'dart:math' show Random;

import 'package:ch5_practical/article_page_widgets/safe_network_image_widget.dart';
import 'package:ch5_practical/extensions.dart';
import 'package:ch5_practical/networking/models/article_model.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

class ArticlesMatrix extends StatelessWidget {
  const ArticlesMatrix(
    this.data, {
    Key? key,
    required this.length,
    required this.columnCount,
    this.replacePage = false,
    required this.imgHeight,
    required this.imgWidth,
  }) : super(key: key);

  final double imgHeight, imgWidth;
  final int length, columnCount;
  final bool replacePage;
  final List<Article> data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        childAspectRatio: (MediaQuery.of(context).size.width / 100.0) * 0.15,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: length,
      itemBuilder: (context, index) {
        String _tag = Random().nextInt(1000).toString();
        return GestureDetector(
          onTap: () => handleArticleNavigation(
            <String, dynamic>{
              'data': data[index],
              'tag': _tag,
            },
            replacePage: replacePage,
          ),
          child: Hero(
            tag: _tag,
            child: Material(
              type: MaterialType.card,
              child: Column(
                children: [
                  SafeImageLoad(
                    src: data[index].urlToImage,
                    width: imgWidth,
                    height: imgHeight,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              (data[index].publishedAt == null)
                                  ? 'no date'
                                  : TimeAgo(data[index].publishedAt!).calculate,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              data[index].title ?? 'No Title Found.',
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              data[index].description ??
                                  'No Description Found.',
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                              ),
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
        );
      },
    );
  }
}
