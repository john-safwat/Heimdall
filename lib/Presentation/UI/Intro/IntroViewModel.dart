import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/Intro/IntroNavigator.dart';

class IntroViewModel extends BaseViewModel<IntroNavigator> {


  onDonePress() {


  }

  // function to return animation suitable for current theme
  String getSecurityAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/lock3.json";
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
      return "assets/animations/qrBlue.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/qrPurple.json";
    }else {
      return "assets/animations/qrBlue.json";
    }
  }

  // function to return animation suitable for current theme
  String getKeyAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/keyLight.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/keyDark2.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/keyDark2.json";
    }else {
      return "assets/animations/keyDark.json";
    }
  }

}
