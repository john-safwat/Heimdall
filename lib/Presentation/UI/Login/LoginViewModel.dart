import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/AddUserUseCase.dart';
import 'package:heimdall/Domain/UseCase/CheckIfUserExistUseCase.dart';
import 'package:heimdall/Domain/UseCase/SignInWithGoogleUseCase.dart';
import 'package:heimdall/Domain/UseCase/SignUserInWithEmailAndPasswordUseCase.dart';
import 'package:heimdall/Presentation/UI/Login/LoginNavigator.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  SignUserInWithEmailAndPasswordUseCase signUserInWithEmailAndPasswordUseCase;
  CheckIfUserExistUseCase checkIfUserExistUseCase;
  AddUserUseCase addUserUseCase;
  SignInWithGoogleUseCase signInWithGoogleUseCase;
  LoginViewModel(
      {required this.signUserInWithEmailAndPasswordUseCase,
      required this.checkIfUserExistUseCase,
      required this.addUserUseCase,
      required this.signInWithGoogleUseCase});

  // define the from key and text field controller
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = false;

  // function to get the horizontal logo based on the theme
  String getLogo() {
    var theme = themeProvider!.getTheme();

    if (theme == MyTheme.blackAndWhiteTheme) {
      return "assets/SVG/LogoBlack.svg";
    } else if (theme == MyTheme.purpleAndWhiteTheme) {
      return "assets/SVG/LogoPurpleLight.svg";
    } else if (theme == MyTheme.darkPurpleTheme) {
      return "assets/SVG/LogoPurpleDark.svg";
    } else {
      return "assets/SVG/LogoBlue.svg";
    }
  }

  // function to change theme to the next theme
  changeTheme() {
    var theme = themeProvider!.getTheme();

    if (theme == MyTheme.blackAndWhiteTheme) {
      themeProvider!.changeTheme(MyTheme.purpleAndWhiteTheme);
    } else if (theme == MyTheme.purpleAndWhiteTheme) {
      themeProvider!.changeTheme(MyTheme.darkPurpleTheme);
    } else if (theme == MyTheme.darkPurpleTheme) {
      themeProvider!.changeTheme(MyTheme.darkBlueTheme);
    } else {
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
  changePasswordVisibility() {
    visible = !visible;
    notifyListeners();
  }

  // navigation functions
  // function to go to the registration screen
  goToRegisterScreen() {
    navigator!.goToRegistrationScreen();
  }

  // function to go to forgetPassword screen
  goToForgetPasswordScreen() {
    navigator!.goToForgetPasswordScreen();
  }

  Future<void> signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      navigator!.showLoading(message: local!.loggingYouIn);
      try {
        var response = await signUserInWithEmailAndPasswordUseCase.invoke(
            email: emailController.text,
            password: passwordController.text,);
        var exist = await checkIfUserExistUseCase.invoke(
            uid: response.uid);
        appConfigProvider!.updateUser(user: response);
        if (exist) {
          navigator!.goBack();
          if (response.emailVerified) {
            navigator!.showSuccessMessage(
                message: local!.welcomeBack,
                posActionTitle: local!.ok,
                posAction: goToHomeScreen);
          } else {
            navigator!.showFailMessage(
                message: local!.emailNotVerified,
                posActionTitle: local!.resend,
                posAction: sendVerificationMail,
                negativeActionTitle: local!.cancel);
          }
        } else {
          try {
            // add user data to database
            await addUserUseCase.invoke(
                user: MyUser(
                    uid: appConfigProvider!.getUser()!.uid,
                    name: appConfigProvider!.getUser()!.displayName ?? "",
                    email: appConfigProvider!.getUser()!.email ?? "",
                    password: "Private",
                    image: appConfigProvider!.getUser()!.photoURL ?? "",
                    phoneNumber: "",
                    birthDate: "--/--/----",
                    gender: "none"));
            navigator!.goBack();
            if (response.emailVerified) {
              navigator!.showSuccessMessage(
                  message: local!.welcomeBack,
                  posActionTitle: local!.ok,
                  posAction: goToHomeScreen);
            } else {
              navigator!.showFailMessage(
                  message: local!.weSentVerificationMail,
                  posActionTitle: local!.ok,
                  posAction: () {});
            }
          } catch (e) {
            throw FirebaseUserAuthException(errorMessage: local!.tryAgain);
          }
        }
      } catch (e) {
        navigator!.goBack();
        navigator!.showFailMessage(
          message: handleErrorMessage(e as Exception),
          posActionTitle: local!.tryAgain,
        );
      }
    }
  }

  // login with google
  // in this function login with google if user doesn't exist it will create a new user in firebase auth
  void loginWithGoogle()async{
    navigator!.showLoading(message: local!.loading);
    try{
      // sing user in using google sign in
      var response = await signInWithGoogleUseCase.invoke();
      // update Provider
      appConfigProvider!.updateUser(user: response);
      try{
        // check if user exist in data base to make sure that we have the user info
        var exist = await checkIfUserExistUseCase.invoke(uid: response.uid);
        // if exist navigate to home screen else add user data to database
        navigator!.goBack();
        if(exist) {
          navigator!.showSuccessMessage(
              message: local!.welcomeBack,
              posActionTitle: local!.ok,
              posAction: goToHomeScreen
          );
        }else {
          try{
            MyUser user = MyUser(
                uid: appConfigProvider!.getUser()!.uid,
                name: appConfigProvider!.getUser()!.displayName ?? "",
                email: appConfigProvider!.getUser()!.email ?? "",
                password: "Private",
                image: appConfigProvider!.getUser()!.photoURL ?? "",
                phoneNumber: "",
                birthDate: "--/--/----",
                gender: "none");
            // add user data to database
            await addUserUseCase.invoke(
                user: user);
            navigator!.showSuccessMessage(
                message: local!.welcomeBack,
                posActionTitle: local!.ok,
                posAction: (){goToExtraInfoScreen(user);}
            );
          }catch(e){
            throw FirebaseDatabaseException(errorMessage: local!.tryAgain);
          }
        }
      }catch(e){
        throw FirebaseDatabaseException(errorMessage: local!.tryAgain);
      }
    }catch(e){
      navigator!.goBack();
      navigator!.showFailMessage(
        message: handleErrorMessage(e as Exception),
        posActionTitle: local!.tryAgain,
      );
    }
  }

  // function to go to Home Screen
  goToHomeScreen() {
    navigator!.goToHomeScreen();
  }

  // function to send Verification mail
  sendVerificationMail() async {
    await appConfigProvider!.getUser()!.sendEmailVerification();
  }

  // function to go to Extra info screen
  goToExtraInfoScreen(MyUser user)async{
    navigator!.goToExtraInfoScreen(user);
  }
}
