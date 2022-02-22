import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/categories_entity.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/data_fetch_store.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/category_card_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/error_card_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/widgets/shimmer_widgets/category_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class CategoryFuturePage extends StatefulWidget {
  const CategoryFuturePage({Key? key}) : super(key: key);

  @override
  _CategoryFuturePageState createState() => _CategoryFuturePageState();
}

class _CategoryFuturePageState extends State<CategoryFuturePage> {
  ObservableFuture<ResultState>? _categoryFuture;

  @override
  void didChangeDependencies() {
    _categoryFuture = Provider.of<DataFetchStore>(context).getCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResultState>(
      future: _categoryFuture,
      builder: (BuildContext context, AsyncSnapshot<ResultState> snapshot) {
        if (snapshot.data is Success) {
          List<String> _categories =
              ((snapshot.data! as Success).value as Categories).names;
          return Container(
            height: 55,
            margin: const EdgeInsets.only(left: 16.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (_, int index) {
                return CategoryCard(_categories[index]);
              },
            ),
          );
        }
        if (snapshot.data is Failure) {
          final ApiException _exception = (snapshot.data as Failure).value;
          return SizedBox(
            height: 55,
            child: ErrorCard(
              description:
                  '${_exception.code ?? ''} ${_exception.message ?? ''}',
            ),
          );
        }
        return const SizedBox(
          height: 55,
          child: CategoryLoadingShimmer(),
        );
      },
    );
  }
}
