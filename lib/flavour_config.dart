import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

class FlavourConfig {
  final Flavour flavourType;
  final ThemeData flavourTheme;
  final ColorScheme colorScheme;
  final String greeting, description;
  final IconData icon;
  static FlavourConfig? _instance;

  factory FlavourConfig({
    required Flavour type,
    required ThemeData theme,
    required ColorScheme shade,
    required String greet,
    required String body,
    required IconData icon,
  }) {
    _instance ??=
        FlavourConfig._internal(type, theme, shade, greet, body, icon);
    return _instance!;
  }

  FlavourConfig._internal(
    this.flavourType,
    this.flavourTheme,
    this.colorScheme,
    this.greeting,
    this.description,
    this.icon,
  );

  static FlavourConfig get instance => _instance!;

  static bool get isDev => _instance!.flavourType == Flavour.development;

  static bool get isProd => _instance!.flavourType == Flavour.production;
}
