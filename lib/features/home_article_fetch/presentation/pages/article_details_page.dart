import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/routing/navigation_service.dart';
import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/data_fetch_store.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/error_card_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/favourite_article_star.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/matrix_article_card.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/no_network_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/safe_network_image_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/section_header_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/article_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage(this.data, {Key? key}) : super(key: key);

  static const String routeName = '/articleDetails';

  final JsonData data;

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  Article get _articleData => widget.data['data'];

  String get _tag => widget.data['tag'];

  ApiException get _exception => (_articleFuture!.result as Failure).value;

  ObservableFuture<ResultState>? _articleFuture;
  bool _hasNetwork = true;

  @override
  void didChangeDependencies() async {
    _articleFuture = Provider.of<DataFetchStore>(context).getArticles();
    _hasNetwork = await Provider.of<DataFetchStore>(context).isConnected;
    super.didChangeDependencies();
  }

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
                      child: SafeImageLoad(
                        src: _articleData.urlToImage,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            _articleData.title,
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
                                flex: 3,
                                child: Text(
                                  _articleData.author,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  _articleData.publishedAt,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: FavouriteArticleStar(
                                  article: _articleData,
                                ),
                              ),
                            ],
                          ),
                          Text(_articleData.content,
                              overflow: TextOverflow.fade),
                          FutureBuilder<ResultState>(
                            future: _articleFuture,
                            builder: (BuildContext context,
                                AsyncSnapshot<ResultState> snapshot) {
                              if (!_hasNetwork) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: const NoInternet(),
                                );
                              }
                              if (snapshot.data is Failure) {
                                return SizedBox(
                                  height: 250,
                                  child: ErrorCard(
                                    desc:
                                        '${_exception.code ?? ''} ${_exception.message ?? ''}',
                                  ),
                                );
                              }
                              if (snapshot.data is Success) {
                                List<Article> _articles =
                                    (snapshot.data as Success<List<Article>>)
                                        .value;
                                return Column(
                                  children: [
                                    const SectionHeader(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.0),
                                      title: 'Similar Articles',
                                    ),
                                    SizedBox(
                                      height: 600.0,
                                      child: ArticlesMatrix(
                                        _articles.sublist(16, 20),
                                        replacePage: true,
                                        length: 4,
                                        columnCount: 2,
                                        imgWidth: 200,
                                        imgHeight: 120,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const ArticleLoadingShimmer(
                                  showHalf: true);
                            },
                          ),
                          const SizedBox(height: 16),
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
}
