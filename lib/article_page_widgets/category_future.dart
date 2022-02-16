import 'dart:convert' show jsonDecode;

import 'package:ch5_practical/custom_cards/category_card_widget.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

class CategoryFuturePage extends StatefulWidget {
  const CategoryFuturePage({Key? key}) : super(key: key);

  @override
  _CategoryFuturePageState createState() => _CategoryFuturePageState();
}

class _CategoryFuturePageState extends State<CategoryFuturePage> {
  late final Future<JsonData> _categoryFuture;

  Future<JsonData> loadJsonData(String source) async {
    late JsonData _jsonResult;
    String _jsonText = await DefaultAssetBundle.of(context).loadString(source);
    _jsonResult = jsonDecode(_jsonText) as JsonData;
    return _jsonResult;
  }

  @override
  void didChangeDependencies() {
    _categoryFuture = loadJsonData(categoryJsonSrc);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<JsonData>(
      future: _categoryFuture,
      builder: (BuildContext context, AsyncSnapshot<JsonData> snapshot) {
        if (snapshot.hasData) {
          List<CategoryCard> _catCards = List.generate(
            snapshot.data!['categories'].length,
            (index) => CategoryCard(
              snapshot.data!['categories'][index],
            ),
          );
          return Container(
            height: 55,
            margin: const EdgeInsets.only(left: 16.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _catCards,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
