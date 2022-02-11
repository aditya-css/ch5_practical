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
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
