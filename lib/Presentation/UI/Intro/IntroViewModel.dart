import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/Intro/IntroNavigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroViewModel extends BaseViewModel<IntroNavigator> {


  onDonePress() async{
    navigator!.showLoading(message: local!.loading);
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("firstTime", false);
      navigator!.goBack();
      navigator!.goToLoginScreen();
    }catch(e){
      navigator!.goBack();
      navigator!.showFailMessage(message: local!.someThingWentWrong);
    }

  }

  String getLocalAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/localBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/localPurple.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/localDarkPurple.json";
    }else {
      return "assets/animations/localGold.json";
    }
  }

  String getHelloAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/helloBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/helloPurple.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/helloDarkPurple.json";
    }else {
      return "assets/animations/helloGold.json";
    }
  }

  // function to return animation suitable for current theme
  String getSecurityAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/emailBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/lock3.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/lock2.json";
    }else {
      return "assets/animations/lock.json";
    }
  }

  // function to return animation suitable for current theme
  String getQRAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/qrLight.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/qrPurple.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/qrDarkPurple.json";
    }else {
      return "assets/animations/qrBlue.json";
    }
  }

  // function to return animation suitable for current theme
  String getKeyAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/loginBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/loginPurple.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/loginPurple.json";
    }else {
      return "assets/animations/loginBlue.json";
    }
  }

  // function to return animation suitable for current theme
  String getChatAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/ChatBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/ChatPurple.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/ChatDarkPurple.json";
    }else {
      return "assets/animations/ChatBlue.json";
    }
  }

}
