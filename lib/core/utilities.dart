import 'package:ch5_practical/core/routing/navigation_service.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/pages/article_details_page.dart';
import 'package:flutter/material.dart';

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
enum CounterActions { increment, decrement }
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
