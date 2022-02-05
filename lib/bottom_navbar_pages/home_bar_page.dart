import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../article_pages/custom_article_card.dart';
import '../custom_error_card.dart';
import '../loading_page.dart';
import '../utilities.dart';

class HomeBarPage extends StatefulWidget {
  const HomeBarPage({Key? key, required this.onActionTap}) : super(key: key);

  final ChangePage<int> onActionTap;

  @override
  _HomeBarPageState createState() => _HomeBarPageState();
}

class _HomeBarPageState extends State<HomeBarPage> {
  String get _title => 'Best Folk Medicine';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                  FutureBuilder<JsonData>(
                    future: loadJsonData(context, categoryJsonSrc),
                    builder: _buildCategoryCardsFuture,
                  ),
                  FutureBuilder<JsonData>(
                    future: loadJsonData(context, articleJsonSrc),
                    builder: _buildArticleCardsFuture,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () => widget.onActionTap(storeIndex),
                  child: const Icon(CupertinoIcons.cart_fill),
                  tooltip: 'Store',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCardsFuture(
      BuildContext context, AsyncSnapshot<JsonData> snapshot) {
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
    } else {
      _child = const SizedBox.shrink();
    }
    return _child;
  }
}

Widget _buildArticleCardsFuture(
    BuildContext context, AsyncSnapshot<JsonData> snapshot) {
  late Widget _child;
  if (snapshot.hasData) {
    _child = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
              snapshot.data!['main_articles'],
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
              snapshot.data!['half_articles'],
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
              snapshot.data!['last_articles'],
              align: CardAlign.matrix,
              imgWidth: 200,
              imgHeight: 120,
            ),
          ),
        ],
      ),
    );
  } else if (snapshot.hasError) {
    _child = SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: const ErrorCard(),
    );
    _child = const LoadingPage();
  } else {
    _child = const LoadingPage();
  }
  return _child;
}
