import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static Future<dynamic> push(String routeName, {Object? args}) =>
      navKey.currentState!.pushNamed(
        routeName,
        arguments: args,
      );

  static Future<dynamic> replace(String routeName, {Object? args}) =>
      navKey.currentState!.pushReplacementNamed(
        routeName,
        arguments: args,
      );

  static void pop() => navKey.currentState!.pop();
}
