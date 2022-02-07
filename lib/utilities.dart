import 'dart:convert' show jsonDecode;

import 'package:flutter/material.dart';

import 'article_pages/article_details_page.dart';
import 'routing/navigation_service.dart';

//TypeDefs
typedef JsonData = Map<String, dynamic>;
typedef ChangeCount<int> = void Function(int value);
typedef ChangePage<String> = void Function(String routeValue);
typedef ChangeColor<Color> = void Function(Color value);

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
const Color kSecondaryVariant = Color(0xff3dd4cf);

//Getters
int get homeIndex => 0;

int get storeIndex => 1;

int get favouriteIndex => 2;

int get settingsIndex => 3;

String get title => 'Best Folk Medicine';

String get categoryJsonSrc => 'assets/dummy_data/categories.json';

String get articleJsonSrc => 'assets/dummy_data/articles.json';

String get cartoonSrc => 'assets/images/zoey.png';

String get cartoonHandSrc => 'assets/images/zoey hand.png';

//Enum
enum CardAlign { vertical, horizontal, matrix }
enum FavouriteActions { increment, decrement }
enum SampleDialogOptions { option1, option2 }

//Functions
Future<JsonData> loadJsonData(BuildContext context, String source) async {
  late Map<String, dynamic> _jsonResult;
  String _jsonText = await DefaultAssetBundle.of(context).loadString(source);
  _jsonResult = jsonDecode(_jsonText);
  return _jsonResult;
}

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
