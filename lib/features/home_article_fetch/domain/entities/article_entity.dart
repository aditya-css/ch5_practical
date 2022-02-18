import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String source, author;
  final String title, description, content;
  final String? urlToImage, publishedAt;

  const Article({
    required this.source,
    required this.author,
    required this.content,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
  });

  @override
  List<Object> get props {
    return [
      source,
      author,
      title,
      description,
      content,
    ];
  }

  @override
  bool get stringify => true;
}
