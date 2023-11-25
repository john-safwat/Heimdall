import 'package:flutter/material.dart';
import 'package:heimdall/Core/Theme/BlackAndWhiteTheme.dart';
import 'package:heimdall/Core/Theme/DarkBlueTheme.dart';
import 'package:heimdall/Core/Theme/DarkPurpleTheme.dart';
import 'package:heimdall/Core/Theme/PurpleAndWhiteTheme.dart';

class MyTheme {
  // define the colors for theme
  static const Color white = Color(0xFFFAFAFA);
  static const Color gray = Color(0xFF585858);
  static const Color black = Color(0xFF1D1D1D);
  static const Color darkPurple = Color(0xFF191B41);
  static const Color lightPurple = Color(0xFF8D91F7);
  static const Color darkBlue = Color(0xFF29384D);
  static const Color lightBlue = Color(0xFFE2F4F6);
  static const Color lightGold = Color(0xFFFFF1D4);
  // this three colors are global colors
  static const Color green = Color(0xFF85CC36);
  static const Color yellow = Color(0xFFF9A541);
  static const Color red = Color(0xFFF73645);

  // define the themes of the app

  // the black & white theme
  static ThemeData blackAndWhiteTheme = BlackAndWhiteTheme.blackAndWhiteTheme;

  // the purple & white theme
  static ThemeData purpleAndWhiteTheme = PurpleAndWhiteTheme.purpleAndWhiteTheme;

  // the darkPurple & lightPurple theme
  static ThemeData darkPurpleTheme = DarkPurpleTheme.darkPurpleTheme;

  // the darkBlue & gold theme
  static ThemeData darkBlueTheme = DarkBlueTheme.darkBlueTheme;
}
