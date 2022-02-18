import 'package:ch5_practical/core/api_const.dart';
import 'package:ch5_practical/core/routing/navigation_service.dart';
import 'package:ch5_practical/core/routing/router.dart';
import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/favourite_counter_sync/presentation/mobx/counter_store.dart';
import 'package:ch5_practical/features/home_article_fetch/data/repositories/data_fetch_repo_impl.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/usecases/article_fetch_usecase.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/usecases/category_fetch_usecase.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/bottom_nav_index_store.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/data_fetch_store.dart';
import 'package:ch5_practical/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BottomNavStore>(create: (_) => BottomNavStore()),
        Provider<CounterStore>(create: (_) => CounterStore()),
        Provider<DataFetchRepositoryImpl>(
          create: (_) => DataFetchRepositoryImpl(
            apiClient: ApiConst.client,
            localJsonClient: ApiConst.localClient,
          ),
        ),
        Provider<DataFetchStore>(
          create: (BuildContext context) => DataFetchStore(
            articleFetch: ArticleFetch(
              Provider.of<DataFetchRepositoryImpl>(context, listen: false),
            ),
            categoryFetch: CategoryFetch(
              Provider.of<DataFetchRepositoryImpl>(context, listen: false),
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
