import 'package:ch5_practical/flavour_config.dart';
import 'package:ch5_practical/main_entrypoint.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

void main() {
  FlavourConfig(
    type: Flavour.production,
    theme: ThemeData.light(),
    shade: ThemeData.light().colorScheme.copyWith(
          secondary: Colors.red,
          background: Colors.black,
          onBackground: Colors.white,
        ),
    greet: 'User',
    body:
        'Hope you are having great experience using this app, developed with a warm heart.'
        ' Please feel free to give any feedback that you like by pressing the below button.',
    icon: Icons.supervised_user_circle,
  );
  runApp(const MyApp());
}
