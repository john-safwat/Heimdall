import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoNavigator.dart';

class ExtraInfoViewModel extends BaseViewModel<ExtraInfoNavigator> {

  late MyUser user;


  // function to return the logo by the theme
  String getLogo(){
    var theme = themeProvider!.getTheme();

    if(theme == MyTheme.blackAndWhiteTheme){
      return "assets/SVG/IconLogoBlack.svg";
    }else if(theme == MyTheme.purpleAndWhiteTheme){
      return "assets/SVG/IconLogoBlack.svg";
    }else if(theme == MyTheme.darkPurpleTheme){
      return "assets/SVG/IconLogoDarkPurple.svg";
    }else {
      return "assets/SVG/IconLogoBlue.svg";
    }
  }


  // function to show modal bottom sheet of the image picker
  showModalBottomSheet(){
    navigator!.showImagePickerModalBottomSheet();
  }
}