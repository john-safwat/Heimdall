import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/Login/LoginNavigator.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{



  // define the from key and text field controller
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = false ;

  // function to get the horizontal logo based on the theme
  String getLogo(){
    var theme = themeProvider!.getTheme();

    if(theme == MyTheme.blackAndWhiteTheme){
      return "assets/SVG/LogoBlack.svg";
    }else if(theme == MyTheme.purpleAndWhiteTheme){
      return "assets/SVG/LogoPurpleLight.svg";
    }else if(theme == MyTheme.darkPurpleTheme){
      return "assets/SVG/LogoPurpleDark.svg";
    }else {
      return "assets/SVG/LogoBlue.svg";
    }
  }

  // function to change theme to the next theme
  changeTheme(){
    var theme = themeProvider!.getTheme();

    if(theme == MyTheme.blackAndWhiteTheme){
      themeProvider!.changeTheme(MyTheme.purpleAndWhiteTheme);
    }else if(theme == MyTheme.purpleAndWhiteTheme){
      themeProvider!.changeTheme(MyTheme.darkPurpleTheme);
    }else if(theme == MyTheme.darkPurpleTheme){
      themeProvider!.changeTheme(MyTheme.darkBlueTheme);
    }else {
      themeProvider!.changeTheme(MyTheme.blackAndWhiteTheme);
    }
  }


  // validation function
  // validate on the email form
  String? emailValidation(String input) {
    if (input.isEmpty) {
      return local!.emailCantBeEmpty;
    } else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(input)) {
      return local!.enterAValidEmail;
    }
    return null;
  }
  // validate the password is not less than 8 chars
  String? passwordValidation(String input) {
    if (input.isEmpty) {
      return local!.passwordCantBeEmpty;
    } else if (input.length < 8) {
      return local!.invalidPasswordLength;
    }
    return null;
  }

  // function to change password visibility
  changePasswordVisibility(){
    visible = !visible;
    notifyListeners();
  }

}