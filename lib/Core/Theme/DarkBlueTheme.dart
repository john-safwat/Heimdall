import 'package:flutter/material.dart';

class DarkBlueTheme {
  // define the colors for theme
  static const Color white = Color(0xFFFAFAFA);
  static const Color gray = Color(0xFF585858);
  static const Color black = Color(0xFF1D1D1D);
  static const Color darkBlue = Color(0xFF29384D);
  static const Color lightBlue = Color(0xFFE2F4F6);
  static const Color lightGold = Color(0xFFFFF1D4);
  // this three colors are global colors
  static const Color red = Color(0xFFF73645);

  // the darkBlue & gold theme
  static ThemeData darkBlueTheme = ThemeData(
      useMaterial3: true,

    // app bar theme
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: lightGold,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, color: lightGold),
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          elevation: 0
      ),
      // set the scaffold background color with the color white
      scaffoldBackgroundColor: darkBlue,
      // set the primary color with the color lightPurple
      primaryColor: lightGold,
      // set the accent color
      secondaryHeaderColor: lightBlue,
      // set the text styles
      textTheme: const TextTheme(
          titleLarge: TextStyle(color: lightGold),
          titleMedium: TextStyle(color: lightGold),
          titleSmall: TextStyle(color: lightGold),
          labelLarge: TextStyle(color: lightGold),
          labelMedium: TextStyle(color: lightGold),
          labelSmall: TextStyle(color: lightGold),
          bodyLarge: TextStyle(color: lightGold),
          bodyMedium: TextStyle(color: lightGold),
          bodySmall: TextStyle(color: lightGold)),
      // set the color of the progress indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: lightGold,
      ),
      // set the elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all(lightGold),
              foregroundColor: MaterialStateProperty.all(darkBlue),
              elevation: MaterialStateProperty.all(0),
              textStyle: MaterialStateProperty.all(const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: darkBlue)))),
      // set the dialog background color
      dialogTheme: const DialogTheme(
        backgroundColor: darkBlue,
      ),

      // set the text from filed decoration
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: const TextStyle(color: red, fontSize: 12),
        contentPadding: const EdgeInsets.all(15),
        iconColor: lightGold,
        hintStyle: const TextStyle(color: lightGold, fontSize: 16),
        prefixIconColor: lightGold,
        suffixIconColor: lightGold,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: lightGold,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: lightGold,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: lightGold,
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
      dividerTheme:const DividerThemeData( color: lightGold ),
      // set text button theme
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              foregroundColor:MaterialStateProperty.all(lightGold) ,
              textStyle: MaterialStateProperty.all(const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: lightGold)))),
      // set modal bottom sheet style
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: darkBlue,
          shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),
          modalBarrierColor: black.withOpacity(0.5)
      ),
      datePickerTheme: DatePickerThemeData(
        surfaceTintColor: lightGold,
        backgroundColor: darkBlue,
        todayBackgroundColor: MaterialStateProperty.all(lightBlue),
        dividerColor: lightGold,
        cancelButtonStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(lightGold)),
        confirmButtonStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(lightGold)),
        dayForegroundColor: MaterialStateProperty.all(lightGold),
        inputDecorationTheme:InputDecorationTheme(
          labelStyle:const TextStyle(color: lightGold, fontSize: 12),
          focusColor: lightBlue,
          helperStyle: const TextStyle(color: lightGold, fontSize: 12),
          errorStyle: const TextStyle(color: red, fontSize: 12),
          iconColor: lightGold,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: const TextStyle(color: gray, fontSize: 16),
          prefixIconColor: lightGold,
          suffixIconColor: lightGold,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: lightGold,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 2,
              color: lightGold,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: lightGold,
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
        weekdayStyle:const TextStyle(color: lightGold),
        yearForegroundColor: MaterialStateProperty.all(lightGold),
        headerHelpStyle: const TextStyle(color: lightGold),
        headerHeadlineStyle:const TextStyle(color: lightGold) ,
        yearStyle: const TextStyle(color: lightGold),
        headerBackgroundColor: darkBlue,
        headerForegroundColor: lightGold,
        rangePickerBackgroundColor: darkBlue,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              color: darkBlue,
              fontSize: 12,
            )
        ),
      ),
      bottomNavigationBarTheme:const BottomNavigationBarThemeData(
          backgroundColor: lightGold,
          selectedIconTheme: IconThemeData(color: darkBlue),
          unselectedIconTheme:IconThemeData(color: darkBlue) ,
          showUnselectedLabels: false,
          showSelectedLabels: false
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: lightGold,
          foregroundColor: darkBlue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          )
      )
  );
}