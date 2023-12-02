import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/AddUserUseCase.dart';
import 'package:heimdall/Domain/UseCase/CreateAccountUseCase.dart';
import 'package:heimdall/Presentation/UI/Registration/RegistrationNavigator.dart';

class RegistrationViewModel extends BaseViewModel<RegistrationNavigator> {

  CreateAccountUseCase createAccountUseCase;
  AddUserUseCase addUserUseCase;
  RegistrationViewModel({required this.createAccountUseCase , required this.addUserUseCase});

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  bool passwordVisible = false;
  bool passwordConfineVisible = false;

  // validation functions
  // validate on the name if it is not empty and doesn't contain ant spacial characters
  String? nameValidation(String name) {
    if (name.isEmpty) {
      return local!.nameCantBeEmpty;
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(name)) {
      return local!.invalidName;
    } else {
      return null;
    }
  }

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

  // validate the password confirmation is not empty and the same as the password
  String? passwordConfirmationValidation(String input) {
    if (input.isEmpty) {
      return local!.passwordCantBeEmpty;
    } else if (input != passwordController.text) {
      return local!.passwordDoseNotMatch;
    }
    return null;
  }


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

  // function to create account
  createAccount()async{
    // if the form key is valid this function will work
    if(formKey.currentState!.validate()){
      navigator!.showLoading(message: local!.loading);
      try {
        // user object that hold all user data
        var user = MyUser(
            uid: "",
            name: nameController.text,
            email: emailController.text,
            password: "Private",
            image: "",
            phoneNumber: "",
            birthDate: "--/--/----",
            gender: "none"
        );
        // call the use case to create user account
        var response = await createAccountUseCase.invoke(user: user);
        // update user in app config provider to allow all app to use it
        appConfigProvider!.updateUser(user: response);
        // update the uid in the user object by the id in response
        user.uid = response.uid;
        await addUserUseCase.invoke(user: user);
        // show success dialog
        navigator!.goBack();
        navigator!.showSuccessMessage(
          message: "${local!.accountCreatedSuccessfully}\n${local!.weSentVerificationMail}",
          posActionTitle: local!.ok,
          posAction:(){goToExtraInfoScreen(user);}
        );
      }catch (e){
        // show fail dialog
        navigator!.goBack();
        navigator!.showFailMessage(message: handleErrorMessage(e as Exception) , negativeActionTitle: local!.tryAgain);
      }
    }

  }

  // function to change password visibility
  changePasswordVisibility(){
    passwordVisible = !passwordVisible;
    notifyListeners();
  }
  // function to change password confirm visibility
  changePasswordConfirmVisibility(){
    passwordConfineVisible = !passwordConfineVisible;
    notifyListeners();
  }

  // navigation function
  // function to go to login screen
  goToLoginScreen(){
    navigator!.goToLoginScreen();
  }

  // function to go to Extra info screen
  goToExtraInfoScreen(MyUser user){
    navigator!.goToExtraInfoScreen(user);
  }

}