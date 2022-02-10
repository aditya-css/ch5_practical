import 'dart:math' show Random;

import 'package:ch5_practical/extensions.dart';
import 'package:ch5_practical/utilities.dart';
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

  final List data;
  final double imgHeight, imgWidth;
  final double? boxWidth, elevation;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        String _tag =
            '$index' + data[index]['image_url'] + '${Random().nextInt(1000)}';
        return GestureDetector(
          onTap: () =>
              handleArticleNavigation({'data': data[index], 'tag': _tag}),
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
                    Image.asset(
                      data[index]['image_url'],
                      fit: BoxFit.cover,
                      width: imgWidth,
                      height: imgHeight,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data[index]['category'],
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            TimeAgo(
                              data[index]['published_date'],
                            ).calculate,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          data[index]['title'],
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
