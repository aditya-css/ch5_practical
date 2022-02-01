import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum CardAlign { vertical, horizontal, matrix }

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required this.data,
    required this.align,
    required this.imgHeight,
    required this.imgWidth,
    this.boxWidth,
    this.elevation,
    this.shadowColor,
  }) : super(key: key);

  final List data;
  final double imgHeight, imgWidth;
  final double? boxWidth, elevation;
  final CardAlign align;
  final Color? shadowColor;

  String timeAgo(String date) {
    DateTime _formattedDate = DateFormat("dd-MM-yyyy").parse(date);
    Duration _diff = DateTime.now().difference(_formattedDate);
    if (_diff.inDays > 365) {
      return "${(_diff.inDays / 365).floor()} ${(_diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (_diff.inDays > 30) {
      return "${(_diff.inDays / 30).floor()} ${(_diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (_diff.inDays > 7) {
      return "${(_diff.inDays / 7).floor()} ${(_diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (_diff.inDays > 0) {
      return "${_diff.inDays} ${_diff.inDays == 1 ? "day" : "days"} ago";
    }
    return "just now";
  }

  @override
  Widget build(BuildContext context) {
    switch (align) {
      case CardAlign.vertical:
        return _buildVerticalCard();
      case CardAlign.horizontal:
        return _buildHorizontalCard(context);
      case CardAlign.matrix:
        return _buildMatrixCard(context);
    }
  }

  ListView _buildVerticalCard() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: boxWidth,
          margin: const EdgeInsets.only(right: 16.0, bottom: 8.0),
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
                        timeAgo(data[index]['published_date']),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
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
              ],
            ),
          ),
        );
      },
    );
  }

  Column _buildHorizontalCard(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  data[index]['image_url'],
                  fit: BoxFit.cover,
                  width: imgWidth,
                  height: imgHeight,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]['title'],
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          timeAgo(data[index]['published_date']),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Text(
                        data[index]['body'],
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
          );
        },
      ),
    );
  }

  GridView _buildMatrixCard(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (MediaQuery.of(context).size.width / 100.0) * 0.15,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              data[index]['image_url'],
              fit: BoxFit.cover,
              width: imgWidth,
              height: imgHeight,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                timeAgo(data[index]['published_date']),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Text(
              data[index]['title'],
              maxLines: 3,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              data[index]['body'],
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
            ),
          ],
        );
      },
    );
  }
}
