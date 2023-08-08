import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color error = Colors.red[700]!;
  static Color appColor = const Color(0xffff70000);
  static const Color primaryColor = Color(0xff36F12C);
  static const Color primaryColorLite = Color(0xff65FF8F);
  static const Color primarySwatchColor = Color(0xff36F12C);
  static final Color primaryDarkColor = Colors.green[700]!;
  static const Color ratingGreyColor = Color(0xffDADADA);
  static const Color ratingYellowColor = Color(0xffF4DD06);
  static const Color addButtonColor = Color(0xff4CAF50);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color yellowColor = Color(0xffF4DD06);
  static Color appColorLight = const Color(0xFFFB8080);
  

  static final ThemeData appThemeData = ThemeData(
    fontFamily: 'WorkSans',
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    primaryColor: primaryColor,
    primaryColorDark: primaryColorLite,
  );
}
