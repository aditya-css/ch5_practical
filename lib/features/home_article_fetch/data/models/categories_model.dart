import 'package:ch5_practical/features/home_article_fetch/domain/entities/categories_entity.dart';

class CategoriesModel extends Categories {
  final List<String> cats;

  const CategoriesModel(this.cats) : super(cats);

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        List.from(
          json['categories'] as List<dynamic>,
        ),
      );
}
