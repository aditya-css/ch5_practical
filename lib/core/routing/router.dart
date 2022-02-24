import 'package:ch5_practical/core/routing/custom_route_transition.dart';
import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/core/widgets/error_card_widget.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/pages/article_details_page.dart';
import 'package:ch5_practical/home_page.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyHomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
        );
      case ArticleDetailPage.routeName:
        {
          var args = settings.arguments;
          if (args is JsonData) {
            return MyRouteTransition(
              ArticleDetailPage(args),
            );
          }
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
