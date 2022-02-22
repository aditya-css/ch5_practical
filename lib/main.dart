import 'package:ch5_practical/core/api_const.dart';
import 'package:ch5_practical/core/routing/navigation_service.dart';
import 'package:ch5_practical/core/routing/router.dart';
import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/favourite_article_local_store/data/data_source/local_database_provider.dart';
import 'package:ch5_practical/features/favourite_article_local_store/data/repositories/data_local_store_repo_impl.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/delete_all_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/get_all_fav_articles_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/is_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/remove_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/usecases/save_fav_article_usecase.dart';
import 'package:ch5_practical/features/favourite_article_local_store/presentation/bloc/db_bloc.dart';
import 'package:ch5_practical/features/home_article_fetch/data/repositories/data_fetch_repo_impl.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/usecases/article_fetch_usecase.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/usecases/category_fetch_usecase.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/bloc/star_bloc.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/bottom_nav_index_store.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/data_fetch_store.dart';
import 'package:ch5_practical/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/favourite_article_local_store/domain/repositories/data_local_store_repository.dart';
import 'features/home_article_fetch/domain/repositories/data_fetch_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
            isFavArticle: IsFavArticle(
              context.read<DataLocalStoreRepository>(),
            ),
          ),
        ),
        BlocProvider<DBloc>(
          create: (BuildContext context) => DBloc(
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
      ],
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: kPrimarySwatch,
          ).copyWith(
            secondary: kSecondaryColor,
            secondaryContainer: kSecondaryContainer,
            error: kErrorColor,
          ),
          textTheme: Theme.of(context).textTheme.copyWith(
                // Defaults
                // NAME         SIZE  WEIGHT  SPACING
                // headline5    24.0  regular  0.0
                // subtitle1    16.0  regular  0.15
                // body2        14.0  regular  0.25  (bodyText2)
                // caption      12.0  regular  0.4
                headline5: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                ),
                subtitle1: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                ),
                caption: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                ),
                bodyText2: GoogleFonts.playfairDisplay(),
              ),
        ),
        navigatorKey: NavigationService.navKey,
        initialRoute: MyHomePage.routeName,
        onGenerateRoute: MyRouter.generateRoute,
      ),
    );
  }
}
