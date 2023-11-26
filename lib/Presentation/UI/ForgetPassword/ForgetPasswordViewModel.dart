import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/ForgetPassword/ForgetPasswordNavigator.dart';

class ForgetPasswordViewModel extends BaseViewModel<ForgetPasswordNavigator>{

  TextEditingController emailController = TextEditingController();

  // function to get the image in the screen
  String getImage(){
    var theme = themeProvider!.getTheme();

    if(theme == MyTheme.blackAndWhiteTheme){
      return "assets/SVG/Forgot password Black.svg";
    }else if(theme == MyTheme.purpleAndWhiteTheme){
      return "assets/SVG/Forgot password Dark Purple.svg";
    }else if(theme == MyTheme.darkPurpleTheme){
      return "assets/SVG/Forgot password Light Burple.svg";
    }else {
      return "assets/SVG/Forgot password Blue.svg";
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

}