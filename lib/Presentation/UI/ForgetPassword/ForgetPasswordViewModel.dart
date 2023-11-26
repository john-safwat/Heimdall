import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/UseCase/ResetPasswordUseCase.dart';
import 'package:heimdall/Presentation/UI/ForgetPassword/ForgetPasswordNavigator.dart';

class ForgetPasswordViewModel extends BaseViewModel<ForgetPasswordNavigator>{

  ResetPasswordUseCase resetPasswordUseCase;
  ForgetPasswordViewModel({required this.resetPasswordUseCase});


  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  // function to get the image in the screen
  String getImage(){
    var theme = themeProvider!.getTheme();

    if(theme == MyTheme.blackAndWhiteTheme){
      return "assets/animations/emailBlack.json";
    }else if(theme == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/emailPurple.json";
    }else if(theme == MyTheme.darkPurpleTheme){
      return "assets/animations/emailDarkPurple.json";
    }else {
      return "assets/animations/emailBlue.json";
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

  // function reset password
  Future<void>resetPassword()async {

    if(formKey.currentState!.validate()){
      navigator!.showLoading(message: local!.loading);
      try{
        await resetPasswordUseCase.invoke(local: localProvider!.getLocal(), email: emailController.text);
        navigator!.goBack();
        navigator!.showSuccessMessage(message: local!.resetPasswordEmailSent , posActionTitle: local!.ok);
      }catch (e){
        // show fail dialog
        navigator!.goBack();
        if(e is FirebaseUserAuthException){
          navigator!.showFailMessage(message: e.errorMessage , negativeActionTitle: local!.tryAgain);
        }else if (e is FirebaseDatabaseException) {
          navigator!.showFailMessage(message: e.errorMessage , negativeActionTitle: local!.tryAgain);
        }else if (e is TimeOutOperationsException){
          navigator!.showFailMessage(message: local!.timeOutError , negativeActionTitle: local!.tryAgain);
        }else {
          navigator!.showFailMessage(message: local!.unknownError , negativeActionTitle: local!.tryAgain);
        }
      }
    }

  }
}