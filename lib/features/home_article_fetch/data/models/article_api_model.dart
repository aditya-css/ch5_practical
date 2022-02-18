import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';

class ArticleApiModel extends Article {
  final Map<String, dynamic> src;
  final String? writer, body;
  final String? heading, desc;
  final String? link, imgUrl, date;

  ArticleApiModel({
    required this.src,
    this.writer,
    this.body,
    this.heading,
    this.desc,
    this.link,
    this.imgUrl,
    this.date,
  }) : super(
          source: src['name'] ?? 'Unknown',
          author: writer ?? 'unknown',
          title: heading ?? 'No Title Found.',
          description: desc ?? 'No Description Found.',
          urlToImage: imgUrl,
          publishedAt: date,
          content: body ?? 'No Content Found.',
        );

  factory ArticleApiModel.fromJson(Map<String, dynamic> json) =>
      ArticleApiModel(
        src: json['source'] as Map<String, dynamic>,
        writer: json['author'] as String?,
        body: json['content'] as String?,
        heading: json['title'] as String?,
        desc: json['description'] as String?,
        link: json['url'] as String?,
        imgUrl: json['urlToImage'] as String?,
        date: json['publishedAt'] as String?,
      );
}
