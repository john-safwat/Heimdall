import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/Setting/SettingNavigator.dart';

class SettingViewModel extends BaseViewModel<SettingNavigator>{

  int selectedIndex = 0;

  List<String> images = [
    "assets/images/theme1.png",
    "assets/images/theme2.png",
    "assets/images/theme3.png",
    "assets/images/theme4.png",
  ];

  String getPreviewImage(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/images/black.png";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/images/lightPurple.png";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/images/darkPurple.png";
    }else {
      return "assets/images/gold.png";
    }
  }

  // function to return the set the initial page;
  void changeSelectedIndex(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      selectedIndex = 0;
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      selectedIndex = 1;
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      selectedIndex = 2;
    }else {
      selectedIndex = 3;
    }
  }
  
  // function to change Theme 
  void changeTheme(int index){
    if(index == 0){
      themeProvider!.changeTheme(MyTheme.blackAndWhiteTheme);
    }else if (index == 1){
      themeProvider!.changeTheme(MyTheme.purpleAndWhiteTheme);
    }else if (index == 2){
      themeProvider!.changeTheme(MyTheme.darkPurpleTheme);
    }else {
      themeProvider!.changeTheme(MyTheme.darkBlueTheme);
    }
  }

  changeLocal(String local){
    localProvider!.changeLocal(local);
  }

}