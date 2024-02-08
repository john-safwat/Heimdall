import 'package:flutter/material.dart';

class DarkPurpleTheme {

  // define the colors for theme
  static const Color white = Color(0xFFFAFAFA);
  static const Color gray = Color(0xFF585858);
  static const Color black = Color(0xFF1D1D1D);
  static const Color darkPurple = Color(0xFF191B41);
  static const Color lightPurple = Color(0xFF8D91F7);
  // this three colors are global colors
  static const Color red = Color(0xFFF73645);



  // the darkPurple & lightPurple theme
  static ThemeData darkPurpleTheme = ThemeData(
    // app bar theme
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: lightPurple,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, color: lightPurple),
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          elevation: 0
      ),
      // set the scaffold background color with the color white
      scaffoldBackgroundColor: darkPurple,
      // set the primary color with the color lightPurple
      primaryColor: lightPurple,
      // set the accent color
      secondaryHeaderColor: white,
      // set the text styles
      textTheme: const TextTheme(
          titleLarge: TextStyle(color: lightPurple),
          titleMedium: TextStyle(color: lightPurple),
          titleSmall: TextStyle(color: lightPurple),
          labelLarge: TextStyle(color: lightPurple),
          labelMedium: TextStyle(color: lightPurple),
          labelSmall: TextStyle(color: lightPurple),
          bodyLarge: TextStyle(color: lightPurple),
          bodyMedium: TextStyle(color: lightPurple),
          bodySmall: TextStyle(color: lightPurple)),
      // set the color of the progress indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: lightPurple,
      ),
      // set the elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all(lightPurple),
              foregroundColor: MaterialStateProperty.all(darkPurple),
              elevation: MaterialStateProperty.all(0),
              textStyle: MaterialStateProperty.all(const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: darkPurple)))),
      // set the dialog background color
      dialogTheme: const DialogTheme(
        backgroundColor: darkPurple,
      ),

      // set the text from filed decoration
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: const TextStyle(color: red, fontSize: 12),
        contentPadding: const EdgeInsets.all(15),
        iconColor: lightPurple,
        hintStyle: const TextStyle(color: lightPurple, fontSize: 16),
        prefixIconColor: lightPurple,
        suffixIconColor: lightPurple,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: lightPurple,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: lightPurple,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: lightPurple,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            )),
      ),
      dividerTheme:const DividerThemeData( color: lightPurple ),
      // set text button theme
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              foregroundColor:MaterialStateProperty.all(lightPurple) ,
              textStyle: MaterialStateProperty.all(const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: lightPurple)))),
      // set modal bottom sheet style
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: darkPurple,
          shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),
          modalBarrierColor: black.withOpacity(0.5)
      ),
      datePickerTheme: DatePickerThemeData(
        surfaceTintColor: lightPurple,
        todayBackgroundColor: MaterialStateProperty.all(white),
        backgroundColor: darkPurple,
        dividerColor: lightPurple,
        cancelButtonStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(lightPurple)),
        confirmButtonStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(lightPurple)),
        dayForegroundColor: MaterialStateProperty.all(lightPurple),
        inputDecorationTheme:InputDecorationTheme(
          labelStyle:const TextStyle(color: lightPurple, fontSize: 12),
          focusColor: white,
          helperStyle: const TextStyle(color: lightPurple, fontSize: 12),
          errorStyle: const TextStyle(color: red, fontSize: 12),
          iconColor: lightPurple,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: const TextStyle(color: gray, fontSize: 16),
          prefixIconColor: lightPurple,
          suffixIconColor: lightPurple,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: lightPurple,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: lightPurple,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: lightPurple,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.red,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.red,
              )),
        ),
        weekdayStyle:const TextStyle(color: lightPurple),
        headerHelpStyle: const TextStyle(color: lightPurple),
        yearForegroundColor: MaterialStateProperty.all(lightPurple),
        yearStyle: const TextStyle(color: lightPurple),
        headerHeadlineStyle:const TextStyle(color: lightPurple) ,
        headerBackgroundColor: darkPurple,
        headerForegroundColor: lightPurple,
        rangePickerBackgroundColor: darkPurple,
      ),
      bottomNavigationBarTheme:const BottomNavigationBarThemeData(
          backgroundColor: lightPurple,
          selectedIconTheme: IconThemeData(color: darkPurple),
          unselectedIconTheme:IconThemeData(color: darkPurple) ,
          showUnselectedLabels: false,
          showSelectedLabels: false
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: lightPurple,
          foregroundColor: darkPurple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          )
      )
  );
}