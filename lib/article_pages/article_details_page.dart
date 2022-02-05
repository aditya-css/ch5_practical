import 'package:flutter/material.dart';

import '../custom_error_card.dart';
import '../loading_page.dart';
import '../routing/navigation_service.dart';
import '../utilities.dart';
import 'custom_article_card.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage(this.data, {Key? key}) : super(key: key);

  static const String routeName = '/articleDetails';

  final JsonData data;

  JsonData get _jsonData => data['data'];

  String get _tag => data['tag'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.pop(),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back_ios),
                        Text('Back'),
                      ],
                    ),
                  ),
                  const Icon(Icons.share),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Hero(
                      tag: _tag,
                      child: Image.asset(
                        _jsonData['image_url'],
                        fit: BoxFit.cover,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            _jsonData['title'],
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Written by ' +
                                      (_jsonData['author'] ?? 'unknown'),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  timeAgo(_jsonData['published_date']),
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.star_rate_rounded),
                                ),
                              ),
                            ],
                          ),
                          Text(
                              _jsonData['body'].toString().isEmpty
                                  ? 'No Body Found.'
                                  : _jsonData['body'],
                              overflow: TextOverflow.fade),
                          FutureBuilder(
                            future: loadJsonData(context, articleJsonSrc),
                            builder: _buildArticleCardsFuture,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'Login To Comment',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('No comments'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCardsFuture(
      BuildContext context, AsyncSnapshot<JsonData> snapshot) {
    late Widget _child;
    if (snapshot.hasData) {
      _child = Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Similar articles',
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
              replacePage: true,
              align: CardAlign.matrix,
              imgWidth: 200,
              imgHeight: 120,
            ),
          ),
        ],
      );
    } else if (snapshot.hasError) {
      _child = const SizedBox(
        height: 300,
        child: ErrorCard(),
      );
      _child = const LoadingPage(showHalf: true);
    } else {
      _child = const LoadingPage(showHalf: true);
    }
    return _child;
  }
}
