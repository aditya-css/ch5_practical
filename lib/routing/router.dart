import 'package:flutter/material.dart';

import '../article_pages/article_details_page.dart';
import '../custom_error_card.dart';
import '../home_page.dart';
import '../utilities.dart';
import 'custom_route_transition.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyHomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
        );
      case ArticleDetailPage.routeName:
        var args = settings.arguments;
        if (args is JsonData) {
          return MyRouteTransition(
            page: ArticleDetailPage(args),
          );
        } else {
          break;
        }
      default:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
        );
    }
    return MaterialPageRoute(
      builder: (BuildContext context) => Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: const ErrorCard(),
        ),
      ),
    );
  }
}
