import 'package:flutter/material.dart';

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
  static ThemeData blackAndWhiteTheme = ThemeData(

    // set the scaffold background color with the color white
    scaffoldBackgroundColor: white,
    // set the primary color with the color black
    primaryColor: black,
    // set the text styles
    textTheme: const TextTheme(
      titleLarge: TextStyle( color: black ),
      titleMedium: TextStyle( color: black ),
      titleSmall: TextStyle( color: black ),
      labelLarge: TextStyle( color: black ),
      labelMedium: TextStyle( color: black ),
      labelSmall: TextStyle( color: black ),
      bodyLarge: TextStyle( color: black ),
      bodyMedium: TextStyle( color: black ),
      bodySmall: TextStyle( color: black )
    ),
    // set the color of the progress indicator
    progressIndicatorTheme:const ProgressIndicatorThemeData(color: black , )

  );

  // the purple & white theme
  static ThemeData purpleAndWhiteTheme = ThemeData(

    // set the scaffold background color with the color white
    scaffoldBackgroundColor: white,
    // set the primary color with the color black
    primaryColor: lightPurple,
    // set the text styles
    textTheme: const TextTheme(
        titleLarge: TextStyle( color: lightPurple ),
        titleMedium: TextStyle( color: lightPurple ),
        titleSmall: TextStyle( color: lightPurple ),
        labelLarge: TextStyle( color: lightPurple ),
        labelMedium: TextStyle( color: lightPurple ),
        labelSmall: TextStyle( color: lightPurple ),
        bodyLarge: TextStyle( color: lightPurple ),
        bodyMedium: TextStyle( color: lightPurple ),
        bodySmall: TextStyle( color: lightPurple )
    ),
    // set the color of the progress indicator
    progressIndicatorTheme:const ProgressIndicatorThemeData(color: lightPurple , )

  );

}