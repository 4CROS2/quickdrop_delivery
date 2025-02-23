import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';

class AppTheme {
  static ThemeData? _instance;

  static ThemeData get instance {
    if (_instance == null) {
      throw Exception('AppTheme not initialized with context');
    }
    return _instance!;
  }

  static void initialize(BuildContext context, {bool isDarkMode = false}) {
    _instance =
        isDarkMode ? _createDarkTheme(context) : _createLightTheme(context);
  }

  static PageTransitionsTheme get _pageTransition => PageTransitionsTheme(
        builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          TargetPlatform.values,
          value: (_) => FadeForwardsPageTransitionsBuilder(),
        ),
      );

  static ThemeData _createLightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Questrial',
      colorSchemeSeed: Constants.primaryColor,
      pageTransitionsTheme: _pageTransition,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        // ignore: deprecated_member_use
        year2023: false,
      ),
    );
  }

  static ThemeData _createDarkTheme(BuildContext context) {
    return ThemeData(
      colorSchemeSeed: Constants.secondaryColor,
      brightness: Brightness.dark,
      fontFamily: 'Questrial',
      pageTransitionsTheme: _pageTransition,
      cardTheme: CardTheme(
        color: Colors.grey,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        // ignore: deprecated_member_use
        year2023: false,
      ),
    );
  }
}
