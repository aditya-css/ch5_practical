import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String source, author, publishedAt;
  final String title, description, content;
  final String? urlToImage;
  final Uint8List? imgBytes;
  final int? id;

  const Article({
    this.id,
    required this.source,
    required this.author,
    required this.content,
    required this.title,
    required this.description,
    required this.urlToImage,
    this.imgBytes,
    required this.publishedAt,
  });

  @override
  List<Object> get props {
    return [
      source,
      author,
      publishedAt,
      title,
      description,
      content,
    ];
  }

  @override
  bool get stringify => true;
}
