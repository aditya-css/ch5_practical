import 'package:ch5_practical/flavour_config.dart';
import 'package:ch5_practical/home_page.dart';
import 'package:ch5_practical/routing/navigation_service.dart';
import 'package:ch5_practical/routing/router.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: FlavourConfig.instance.flavourTheme.copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: kPrimarySwatch,
        ).copyWith(
          secondary: kSecondaryColor,
          secondaryVariant: kSecondaryVariant,
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
                color: FlavourConfig.instance.colorScheme.background,
              ),
              subtitle1: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                color: FlavourConfig.instance.colorScheme.background,
              ),
              caption: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                color: FlavourConfig.instance.colorScheme.background,
              ),
              bodyText2: GoogleFonts.playfairDisplay(
                color: FlavourConfig.instance.colorScheme.background,
              ),
            ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: FlavourConfig.isDev ? kSecondaryColor : kSecondaryVariant,
          ),
        ),
      ),
      navigatorKey: NavigationService.navKey,
      initialRoute: MyHomePage.routeName,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
