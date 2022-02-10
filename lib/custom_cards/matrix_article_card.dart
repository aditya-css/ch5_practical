import 'dart:math' show Random;

import 'package:ch5_practical/extensions.dart';
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
  final List data;

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
        String _tag =
            '$index' + data[index]['image_url'] + '${Random().nextInt(1000)}';
        return GestureDetector(
          onTap: () => handleArticleNavigation(
            {'data': data[index], 'tag': _tag},
            replacePage: replacePage,
          ),
          child: Hero(
            tag: _tag,
            child: Material(
              type: MaterialType.card,
              child: Column(
                children: [
                  Image.asset(
                    data[index]['image_url'],
                    fit: BoxFit.cover,
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
                              TimeAgo(
                                data[index]['published_date'],
                              ).calculate,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              data[index]['title'],
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
                              data[index]['body'],
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
