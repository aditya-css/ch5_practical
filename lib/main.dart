import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Folk Medicine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        primarySwatch: Colors.blueGrey,
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
      home: const MyHomePage(),
    );
  }
}
