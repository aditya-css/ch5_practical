import 'package:ch5_practical/article_page_widgets/safe_network_image_widget.dart';
import 'package:ch5_practical/article_page_widgets/section_header_widget.dart';
import 'package:ch5_practical/custom_cards/matrix_article_card.dart';
import 'package:ch5_practical/custom_error_card.dart';
import 'package:ch5_practical/extensions.dart';
import 'package:ch5_practical/loading_page.dart';
import 'package:ch5_practical/networking/api_constants.dart';
import 'package:ch5_practical/networking/models/api_response_model.dart';
import 'package:ch5_practical/networking/models/article_model.dart';
import 'package:ch5_practical/routing/navigation_service.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

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

  String get _author => 'Written by ' + (_articleData.author ?? 'unknown');

  String get _body => _articleData.content ?? 'No Content Found.';
  String get _title => _articleData.title ?? 'No Title Found.';

  late final Future<Response<ApiResponse>> _articleFuture;

  @override
  void didChangeDependencies() {
    _articleFuture = ApiConst.chopperClient.getTopNews();
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
                            _title,
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
                                  _author,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  TimeAgo(_articleData.publishedAt).calculate,
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
                          Text(_body, overflow: TextOverflow.fade),
                          FutureBuilder<Response<ApiResponse>>(
                            future: _articleFuture,
                            builder: (BuildContext context,
                                AsyncSnapshot<Response<ApiResponse>> snapshot) {
                              if (snapshot.hasError) {
                                return const SizedBox(
                                  height: 250,
                                  child: ErrorCard(),
                                );
                              }
                              if (snapshot.hasData) {
                                if (snapshot.data!.body!.status == 'error') {
                                  return const SizedBox(
                                    height: 250,
                                    child: ErrorCard(),
                                  );
                                }
                                ApiResponse _data = snapshot.data!.body!;
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
                                        _data.articles!.sublist(16, 20),
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
                              return const LoadingPage(showHalf: true);
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
