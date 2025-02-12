import 'package:flutter/material.dart';

class Theme {
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

  static ThemeData _createLightTheme(BuildContext context) {
    return ThemeData(
      fontFamily: 'Questrial',
    );
  }

  static ThemeData _createDarkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Questrial',
    );
  }
}
