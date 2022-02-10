import 'package:ch5_practical/home_page.dart';
import 'package:ch5_practical/routing/navigation_service.dart';
import 'package:ch5_practical/routing/router.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
