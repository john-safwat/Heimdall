import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/Setting/SettingNavigator.dart';

class SettingViewModel extends BaseViewModel<SettingNavigator>{

  int selectedIndex = 0;

  List<String> images = [
    "assets/images/theme1.png",
    "assets/images/theme4.png",
    "assets/images/theme2.png",
    "assets/images/theme3.png",
  ];

  // function to return the set the initial page;
  void changeSelectedIndex(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      selectedIndex = 0;
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      selectedIndex = 2;
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      selectedIndex = 1;
    }else {
      selectedIndex = 3;
    }
  }
  
  // function to change Theme 
  void changeTheme(int index){
    if(index == 0){
      themeProvider!.changeTheme(MyTheme.blackAndWhiteTheme);
    }else if (index == 2){
      themeProvider!.changeTheme(MyTheme.purpleAndWhiteTheme);
    }else if (index == 1){
      themeProvider!.changeTheme(MyTheme.darkPurpleTheme);
    }else {
      themeProvider!.changeTheme(MyTheme.darkBlueTheme);
    }
  }

}