import 'package:ch5_practical/core/models_and_entities/article_entity.dart';
import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/core/widgets/error_card_widget.dart';
import 'package:ch5_practical/core/widgets/no_network_widget.dart';
import 'package:ch5_practical/core/widgets/shimmer_widgets/article_loading_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/data_fetch_store.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/horizontal_article_card.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/matrix_article_card.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/section_header_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/vertical_article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ArticleFuturePage extends StatefulWidget {
  const ArticleFuturePage({Key? key}) : super(key: key);

  @override
  State<ArticleFuturePage> createState() => _ArticleFuturePageState();
}

class _ArticleFuturePageState extends State<ArticleFuturePage> {
  List<Article> get _articles =>
      (_articleFuture!.result as Success<List<Article>>).value;

  ApiException get _exception => (_articleFuture!.error as Failure).value;

  double get _fullScreenCardHeight => MediaQuery.of(context).size.height * 0.55;

  ObservableFuture<ResultState>? _articleFuture;
  bool _hasNetwork = true;

  @override
  void didChangeDependencies() async {
    _articleFuture = context.watch<DataFetchStore>().getArticles();
    _hasNetwork = await context.watch<DataFetchStore>().isConnected;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (!_hasNetwork) {
          return SizedBox(
            height: _fullScreenCardHeight,
            child: const NoInternet(),
          );
        }
        if (_articleFuture == null) {
          return const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ArticleLoadingShimmer(),
          );
        }
        switch (_articleFuture!.status) {
          case FutureStatus.pending:
            return const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: ArticleLoadingShimmer(),
            );
          case FutureStatus.rejected:
            return SizedBox(
              height: _fullScreenCardHeight,
              child: ErrorCard(
                description:
                    '${_exception.code ?? ''} ${_exception.message ?? ''}',
              ),
            );
          case FutureStatus.fulfilled:
            {
              if (_articleFuture!.result is Success) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SectionHeader(
                        padding: EdgeInsets.only(bottom: 16.0),
                        title: 'Main Articles',
                      ),
                      SizedBox(
                        height: 300.0,
                        child: ArticlesVertical(
                          _articles.sublist(0, 10),
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
                        height: 435.0,
                        child: ArticlesHorizontal(
                          _articles.sublist(11, 14),
                          length: 3,
                          imgHeight: 128,
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
                          _articles.sublist(15, 19),
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
              return SizedBox(
                height: _fullScreenCardHeight,
                child: ErrorCard(
                  description:
                      '${_exception.code ?? ''} ${_exception.message ?? ''}',
                ),
              );
            }
        }
      },
    );
  }
}
