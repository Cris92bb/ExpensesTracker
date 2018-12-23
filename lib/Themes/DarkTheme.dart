import 'package:flutter/material.dart';

class DarkTheme{
  static var theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(
    ),
    primaryColorDark: Colors.black,
    buttonColor: Colors.white,
    accentColor: Colors.white,
    fontFamily: 'Farsan',
    primaryColorLight: Colors.white,
  );
}