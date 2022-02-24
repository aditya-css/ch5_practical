import 'package:ch5_practical/core/api_const.dart';
import 'package:ch5_practical/core/routing/navigation_service.dart';
import 'package:ch5_practical/features/favourite_article_local_store/data/data_source/local_database_provider.dart';
import 'package:ch5_practical/features/favourite_article_local_store/data/repositories/data_local_store_repo_impl.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/repositories/data_local_store_repository.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/delete_all_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/find_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/get_all_fav_articles_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/remove_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/save_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc.dart';
import 'package:ch5_practical/features/home_article_fetch/data/repositories/data_fetch_repo_impl.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/repositories/data_fetch_repository.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/usecases/article_fetch_usecase.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/usecases/category_fetch_usecase.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/bloc/star_bloc.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/bottom_nav_index_store.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/data_fetch_store.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/pages/article_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

//TypeDefs
typedef JsonData = Map<String, dynamic>;

//Const Colors
const MaterialColor kPrimarySwatch = MaterialColor(
  0xff4b2e40,
  <int, Color>{
    50: Color(0xff44293a),
    100: Color(0xff3c2533),
    200: Color(0xff35202d),
    300: Color(0xff2d1c26),
    400: Color(0xff261720),
    500: Color(0xff1e121a),
    600: Color(0xff160e13),
    700: Color(0xff0f090d),
    800: Color(0xff070506),
    900: Color(0xff000000),
  },
);
const Color kSecondaryColor = Color(0xffea7b88);
const Color kSecondaryContainer = Color(0xff3dd4cf);
const Color kErrorColor = Colors.limeAccent;

//Provider list
final List<SingleChildWidget> providersList = <SingleChildWidget>[
  Provider<BottomNavStore>(
    create: (_) => BottomNavStore(),
  ),
  Provider<DataFetchRepository>(
    create: (_) => DataFetchRepositoryImpl(
      apiClient: ApiConst.client,
      localJsonClient: ApiConst.localClient,
    ),
  ),
  Provider<DataLocalStoreRepository>(
    create: (_) => DataLocalStoreRepositoryImpl(
      LocalDatabaseProvider.dbProvider,
    ),
  ),
  ProxyProvider<DataFetchRepository, DataFetchStore>(
    update: (_, dataFetchRepo, ___) => DataFetchStore(
      articleFetch: ArticleFetch(dataFetchRepo),
      categoryFetch: CategoryFetch(dataFetchRepo),
    ),
  ),
  BlocProvider<StarBloc>(
    create: (BuildContext context) => StarBloc(
      saveFavArticle: SaveFavArticle(
        context.read<DataLocalStoreRepository>(),
      ),
      removeFavArticle: RemoveFavArticle(
        context.read<DataLocalStoreRepository>(),
      ),
      isFavArticle: FindFavArticle(
        context.read<DataLocalStoreRepository>(),
      ),
    ),
  ),
  BlocProvider<DatabaseBloc>(
    create: (BuildContext context) => DatabaseBloc(
      starBloc: context.read<StarBloc>(),
      getAllFavArticles: GetAllFavArticles(
        context.read<DataLocalStoreRepository>(),
      ),
      deleteAllFavArticles: DeleteAllFavArticles(
        context.read<DataLocalStoreRepository>(),
      ),
      removeFavArticle: RemoveFavArticle(
        context.read<DataLocalStoreRepository>(),
      ),
    ),
  ),
];

//Getters
int get homeIndex => 0;

int get storeIndex => 1;

int get favouriteIndex => 2;

int get settingsIndex => 3;

String get title => 'Best Folk Medicine';

String get categoryJsonSrc => 'assets/dummy_data/categories.json';

String get noWifiImageSrc => 'assets/images/no_wifi.png';

String get cartoonSrc => 'assets/images/zoey.png';

String get cartoonHandSrc => 'assets/images/zoey hand.png';

//Enum
enum SampleDialogOptions { option1, option2 }

//Functions
void handleArticleNavigation(JsonData data, {bool replacePage = false}) {
  if (replacePage) {
    NavigationService.replace(
      ArticleDetailPage.routeName,
      args: data,
    );
  } else {
    NavigationService.push(
      ArticleDetailPage.routeName,
      args: data,
    );
  }
}
