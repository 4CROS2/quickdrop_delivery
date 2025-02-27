import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static double minHeight = 100.0;
  static double paddingValue = 24;
  static double borderValue = paddingValue;

  ///main border radius
  static BorderRadius mainBorderRadius = BorderRadius.circular(borderValue);

  static const AlwaysScrollableScrollPhysics bouncingScrollPhysics =
      AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );

  static OutlineInputBorder authBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: Constants.mainBorderRadius,
  );

  static TextStyle inputsTextStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'RedHat',
    fontSize: 14,
  );
  static TextStyle errorTextStyle = inputsTextStyle.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 12,
  );
  static Color primaryColor = const Color(
    0xFFFFA500,
  );
  static const Color secondaryColor = Color(0xFF333333);

  static EdgeInsets mainPadding = EdgeInsets.all(paddingValue);
  static EdgeInsets buttonPadding = EdgeInsets.all(paddingValue);

  static Duration animationTransition = const Duration(milliseconds: 400);

  static ImageFilter iamgeFilterBlur = ImageFilter.blur(
    sigmaX: 20,
    sigmaY: 20,
  );
}
