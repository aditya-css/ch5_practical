import 'package:ch5_practical/custom_cards/horizontal_article_card.dart';
import 'package:ch5_practical/custom_cards/matrix_article_card.dart';
import 'package:ch5_practical/custom_cards/vertical_article_card.dart';
import 'package:flutter/material.dart';

import '../custom_error_card.dart';
import '../loading_page.dart';
import '../utilities.dart';
import 'section_header_widget.dart';

class ArticleFuturePage extends StatefulWidget {
  const ArticleFuturePage({Key? key}) : super(key: key);

  @override
  State<ArticleFuturePage> createState() => _ArticleFuturePageState();
}

class _ArticleFuturePageState extends State<ArticleFuturePage> {
  late final Future<JsonData> _articleFuture;

  @override
  void didChangeDependencies() {
    _articleFuture = loadJsonData(context, articleJsonSrc);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<JsonData>(
      future: _articleFuture,
      builder: (BuildContext context, AsyncSnapshot<JsonData> snapshot) {
        if (snapshot.hasError) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: const ErrorCard(),
          );
        }
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SectionHeader(
                  padding: EdgeInsets.only(bottom: 16.0),
                  title: 'Main Articles',
                ),
                SizedBox(
                  height: 290.0,
                  child: ArticlesVertical(
                    snapshot.data!['main_articles'],
                    imgHeight: 150,
                    imgWidth: 250,
                    boxWidth: 240,
                    elevation: 15,
                    shadowColor: Colors.grey.shade200,
                  ),
                ),
                const SectionHeader(
                  padding: EdgeInsets.only(top: 20.0),
                  title: 'You have not finished reading',
                ),
                SizedBox(
                  height: 400.0,
                  child: ArticlesHorizontal(
                    snapshot.data!['half_articles'],
                    length: 3,
                    imgHeight: 110,
                    imgWidth: 150,
                  ),
                ),
                const SectionHeader(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  title: 'Last articles',
                ),
                SizedBox(
                  height: 600.0,
                  child: ArticlesMatrix(
                    snapshot.data!['last_articles'],
                    length: 4,
                    columnCount: 2,
                    imgWidth: 200,
                    imgHeight: 120,
                  ),
                ),
              ],
            ),
          );
        }
        return const LoadingPage();
      },
    );
  }
}
