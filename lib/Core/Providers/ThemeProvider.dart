import 'package:flutter/material.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  // define the theme data to read from
  ThemeData _theme = MyTheme.darkBlueTheme;

  // function to change the theme
  Future<void> changeTheme (ThemeData themeData) async {
    // if the theme is the same theme them it will terminate the process
    if (themeData == _theme) {return;}

    // reed the shared preferences to read the old value of the theme
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _theme = themeData;

    // update the value of key "theme" to the current theme value
    if(_theme == MyTheme.blackAndWhiteTheme){
      prefs.setString("theme", "BlackAndWhite");
    }else if(_theme == MyTheme.purpleAndWhiteTheme){
      prefs.setString("theme", "PurpleAndWhite");
    }else if(_theme == MyTheme.darkPurpleTheme){
      prefs.setString("theme", "DarkPurpleTheme");
    }else {
      prefs.setString("theme", "DarkBlueTheme");
    }

    // notify all listeners on the theme values
    notifyListeners();
  }

  // function to reed theme
  ThemeData getTheme(){
    return _theme;
  }

  // function to set the splash logo image
  String getSplashLogo(){
    if(_theme == MyTheme.blackAndWhiteTheme){
      return "assets/SVG/SplashLogoDW.svg";
    }else if(_theme == MyTheme.purpleAndWhiteTheme){
      return "assets/SVG/SplashLogoWP.svg";
    }else if(_theme == MyTheme.darkPurpleTheme){
      return "assets/SVG/SplashLogoPP.svg";
    }else {
      return "assets/SVG/SplashLogoBG.svg";
    }
  }


  Color getPrimaryColor(){
    if(_theme == MyTheme.blackAndWhiteTheme){
      return MyTheme.blackAndWhiteTheme.primaryColor;
    }else if(_theme == MyTheme.purpleAndWhiteTheme){
      return MyTheme.purpleAndWhiteTheme.primaryColor;
    }else if(_theme == MyTheme.darkPurpleTheme){
      return MyTheme.darkPurpleTheme.primaryColor;
    }else {
      return MyTheme.darkBlueTheme.primaryColor;
    }
  }

  Color getSecondaryColor(){
    if(_theme == MyTheme.blackAndWhiteTheme){
      return MyTheme.blackAndWhiteTheme.secondaryHeaderColor;
    }else if(_theme == MyTheme.purpleAndWhiteTheme){
      return MyTheme.purpleAndWhiteTheme.secondaryHeaderColor;
    }else if(_theme == MyTheme.darkPurpleTheme){
      return MyTheme.darkPurpleTheme.secondaryHeaderColor;
    }else {
      return MyTheme.darkBlueTheme.secondaryHeaderColor;
    }
  }

}