import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/UseCase/ChangePasswordUseCase.dart';
import 'package:heimdall/Presentation/UI/ChangePassword/ChangePasswordNavigator.dart';

class ChangePasswordViewModel extends BaseViewModel<ChangePasswordNavigator>{

  ChangePasswordUseCase changePasswordUseCase;
  ChangePasswordViewModel({required this.changePasswordUseCase});

  bool passwordVisible = false;
  bool newPasswordVisible = false;
  bool newPasswordConfirmationVisible = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmationController = TextEditingController();

  Future<void> updatePassword()async{
    if(formKey.currentState!.validate()){
      try{
        navigator!.showLoading(message: local!.loading);
        await changePasswordUseCase.invoke(
            email: appConfigProvider!.user!.email!,
            password: passwordController.text,
            newPassword: newPasswordController.text
        );
        passwordController.text = "";
        newPasswordController.text = "";
        newPasswordConfirmationController.text = "";
        navigator!.goBack();
        navigator!.showSuccessMessage(message: local!.passwordUpdated , posActionTitle: local!.ok);
      }catch(e){
        navigator!.goBack();
        navigator!.showFailMessage(message: handleErrorMessage(e as Exception) , posActionTitle: local!.tryAgain);
      }
    }
  }


  // function to return animation suitable for current theme
  String getResetPasswordAnimations(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/changePasswordBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/changePasswordPurple.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/changePasswordDarkPurple.json";
    }else {
      return "assets/animations/changePasswordGold.json";
    }
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

  // validate the password confirmation is not empty and the same as the password
  String? passwordConfirmationValidation(String input) {
    if (input.isEmpty) {
      return local!.passwordCantBeEmpty;
    } else if (input != newPasswordController.text) {
      return local!.passwordDoseNotMatch;
    }
    return null;
  }

  void changePasswordVisibility(){
    passwordVisible = !passwordVisible;
    notifyListeners();
  }
  void changeNewPasswordVisibility(){
    newPasswordVisible = !newPasswordVisible;
    notifyListeners();
  }
  void changeNewPasswordConfirmationVisibility(){
    newPasswordConfirmationVisible = !newPasswordConfirmationVisible;
    notifyListeners();
  }

}