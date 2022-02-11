import 'package:ch5_practical/networking/models/article_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_model.g.dart';

@JsonSerializable()
class ApiResponse {
  late final String status;
  late final String? code, message;
  late final int? totalResults;
  late final List<Article>? articles;

  ApiResponse({
    required this.status,
    this.code,
    this.message,
    this.totalResults,
    this.articles,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
}
