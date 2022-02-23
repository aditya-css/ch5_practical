import 'dart:typed_data';

import 'package:ch5_practical/core/db_const.dart';
import 'package:ch5_practical/core/extensions.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';

class ArticleApiModel extends Article {
  final int? aid;
  final Map<String, dynamic>? src;
  final String? writer, body;
  final String? heading, desc;
  final String? link, imgUrl;
  final Uint8List? imgBinary;
  final String date;

  ArticleApiModel({
    this.aid,
    required this.src,
    this.writer,
    this.body,
    this.heading,
    this.desc,
    this.link,
    this.imgUrl,
    this.imgBinary,
    required this.date,
  }) : super(
          id: aid,
          source: src['name'] ?? 'Unknown',
          author: writer ?? 'unknown',
          title: heading ?? 'No Title Found.',
          description: desc ?? 'No Description Found.',
          urlToImage: imgUrl,
          imgBytes: imgBinary,
          publishedAt: date,
          content: body ?? 'No Content Found.',
        );

  factory ArticleApiModel.fromJson(Map<String, dynamic> json) =>
      ArticleApiModel(
        aid: json['id'] as int?,
        src: json['source'] as Map<String, dynamic>?,
        writer: json['author'] as String?,
        body: json['content'] as String?,
        heading: json['title'] as String?,
        desc: json['description'] as String?,
        link: json['url'] as String?,
        imgUrl: json['urlToImage'] as String?,
        imgBinary: json['imageBlob'] as Uint8List?,
        date: TimeAgo(json['publishedAt']).calculate,
      );

  Map<String, dynamic> toDBJson() => {
        DBConst.colAuthor: writer,
        DBConst.colTitle: heading,
        DBConst.colDesc: desc,
        DBConst.colBody: body,
        DBConst.colImg: imgUrl,
        DBConst.colImgBlob: imgBinary,
        DBConst.colDate: date
      };
}
