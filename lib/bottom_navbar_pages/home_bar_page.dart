import 'dart:convert';

import 'package:flutter/material.dart';

import '/custom_article_card.dart';

class HomeBarPage extends StatefulWidget {
  const HomeBarPage({Key? key}) : super(key: key);

  @override
  _HomeBarPageState createState() => _HomeBarPageState();
}

class _HomeBarPageState extends State<HomeBarPage> {
  //Getters
  String get _title => 'Best Folk Medicine';
  String get _categoryJsonSrc => 'assets/dummy_data/categories.json';
  String get _articleJsonSrc => 'assets/dummy_data/articles.json';

  Future<Map<String, dynamic>> loadJsonData(
      BuildContext context, String source) async {
    late Map<String, dynamic> _jsonResult;
    String _jsonText = await DefaultAssetBundle.of(context).loadString(source);
    _jsonResult = json.decode(_jsonText);
    return _jsonResult;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 20,
                  shadowColor: Colors.grey.shade50,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.grey.shade300,
                        size: 30,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              FutureBuilder(
                future: loadJsonData(context, _categoryJsonSrc),
                builder: _buildCategoryCardsFuture,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder(
                  future: loadJsonData(context, _articleJsonSrc),
                  builder: _buildArticleCardsFuture,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCardsFuture(
      BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
    late Widget _child;
    if (snapshot.hasData) {
      List<Container> _catCards = [];
      for (int index = 0;
          index < snapshot.data!['categories'].length;
          index++) {
        _catCards.add(
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(right: 16.0),
            child: Text(
              snapshot.data!['categories'][index],
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
            ),
          ),
        );
      }
      _child = Container(
        height: 55,
        margin: const EdgeInsets.only(left: 16.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _catCards,
        ),
      );
    } else if (snapshot.hasError) {
      _child = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: _buildErrorCard(),
      );
    } else {
      _child = const Center(child: CircularProgressIndicator());
    }
    return _child;
  }
}

Widget _buildArticleCardsFuture(
    BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
  late Widget _child;
  if (snapshot.hasData) {
    _child = Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Main Articles',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                'See more',
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 290.0,
          child: ArticleCard(
            data: snapshot.data!['main_articles'],
            align: CardAlign.vertical,
            imgHeight: 150,
            imgWidth: 250,
            boxWidth: 240,
            elevation: 15,
            shadowColor: Colors.grey.shade200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'You have not finished reading',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                'See more',
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 400.0,
          child: ArticleCard(
            data: snapshot.data!['half_articles'],
            align: CardAlign.horizontal,
            imgHeight: 110,
            imgWidth: 150,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last articles',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                'See more',
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 600.0,
          child: ArticleCard(
            data: snapshot.data!['last_articles'],
            align: CardAlign.matrix,
            imgWidth: 200,
            imgHeight: 120,
          ),
        ),
      ],
    );
  } else if (snapshot.hasError) {
    _child = _buildErrorCard();
  } else {
    _child = const Padding(
      padding: EdgeInsets.only(top: 28.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
  return _child;
}

Container _buildErrorCard() {
  return Container(
    height: 100,
    color: Colors.red,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'ERROR',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
              ),
            ),
            Icon(Icons.info, color: Colors.amber),
          ],
        ),
        const Text(
          'Failed to retrieve data!',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
