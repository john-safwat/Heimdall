import 'package:flutter/material.dart';

class BlackAndWhiteTheme {
  // define the colors for theme
  static const Color white = Color(0xFFFAFAFA);
  static const Color gray = Color(0xFF585858);
  static const Color black = Color(0xFF1D1D1D);
  static const Color red = Color(0xFFF73645);


  static ThemeData blackAndWhiteTheme = ThemeData(

    // app bar theme
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: black,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, color: black),
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          elevation: 0
      ),
      // set the scaffold background color with the color white
      scaffoldBackgroundColor: white,
      // set the primary color with the color black
      primaryColor: black,
      // set the accent color
      secondaryHeaderColor: gray,
      // set the text styles
      textTheme: const TextTheme(
          titleLarge: TextStyle(color: black),
          titleMedium: TextStyle(color: black),
          titleSmall: TextStyle(color: black),
          labelLarge: TextStyle(color: black),
          labelMedium: TextStyle(color: black),
          labelSmall: TextStyle(color: black),
          bodyLarge: TextStyle(color: black),
          bodyMedium: TextStyle(color: black),
          bodySmall: TextStyle(color: black)),
      // set the color of the progress indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: black,
      ),
      // set the elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all(black),
              foregroundColor: MaterialStateProperty.all(white),
              elevation: MaterialStateProperty.all(0),
              textStyle: MaterialStateProperty.all(const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16, color: white)))),
      // set the dialog background color
      dialogTheme: const DialogTheme(
        backgroundColor: white,
      ),

      // set the text from filed decoration
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: const TextStyle(color: red, fontSize: 12),
        iconColor: black,
        contentPadding: const EdgeInsets.all(15),
        hintStyle: const TextStyle(color: black, fontSize: 16),
        prefixIconColor: black,
        suffixIconColor: black,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: black,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: black,
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
      dividerTheme:const DividerThemeData( color: black ),
      // set text button theme
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              foregroundColor:MaterialStateProperty.all(black) ,
              textStyle: MaterialStateProperty.all(const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: black)))),

      // set modal bottom sheet style
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: white,
          shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),
          modalBarrierColor: black.withOpacity(0.5)
      ),
      datePickerTheme: DatePickerThemeData(
        surfaceTintColor: white,
        todayBackgroundColor: MaterialStateProperty.all(white),
        backgroundColor: white,
        dividerColor: black,
        cancelButtonStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(black)),
        confirmButtonStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(black)),
        dayForegroundColor: MaterialStateProperty.all(black),
        inputDecorationTheme:InputDecorationTheme(
          labelStyle:const TextStyle(color: black, fontSize: 12),
          focusColor: gray.withOpacity(0.6),
          helperStyle: const TextStyle(color: black, fontSize: 12),
          errorStyle: const TextStyle(color: red, fontSize: 12),
          iconColor: black,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: const TextStyle(color: gray, fontSize: 16),
          prefixIconColor: black,
          suffixIconColor: black,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: black,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: black,
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
        weekdayStyle:const TextStyle(color: black),
        yearForegroundColor: MaterialStateProperty.all(black),
        yearStyle: const TextStyle(color: black),
        headerHelpStyle: const TextStyle(color: black),
        headerHeadlineStyle:const TextStyle(color: black) ,
        headerBackgroundColor: white,
        headerForegroundColor: black,
        rangePickerBackgroundColor: white,
      ),

    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
      backgroundColor: black,
      selectedIconTheme: IconThemeData(color: white),
      unselectedIconTheme:IconThemeData(color: white) ,
      showUnselectedLabels: false,
      showSelectedLabels: false
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: black,
      foregroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      )
    )
  );
}