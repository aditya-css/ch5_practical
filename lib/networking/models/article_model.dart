import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class Article {
  late final Map source;
  late final String? author, content;
  late final String? title, description;
  late final String? url, urlToImage, publishedAt;

  Article({
    required this.source,
    this.author,
    this.content,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
