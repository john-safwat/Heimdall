import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/GetUserDataUseCase.dart';
import 'package:heimdall/Presentation/UI/UpdateProfile/UpdateProfileNavigator.dart';

class UpdateProfileViewModel extends BaseViewModel<UpdateProfileNavigator> {

  GetUserDataUseCase getUserDataUseCase;
  UpdateProfileViewModel({required this.getUserDataUseCase});

  MyUser? user;
  String? errorMessage;

  // function to update user
  loadUserData()async{
    user = null;
    errorMessage = null;
    notifyListeners();

    try{
      user = await getUserDataUseCase.invoke(uid: appConfigProvider!.user!.uid);
      notifyListeners();
    }catch(e){
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }

  }

  // function to show modal bottom sheet of the image picker
  showModalBottomSheet(){
    navigator!.showImagePickerModalBottomSheet();
  }

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


}