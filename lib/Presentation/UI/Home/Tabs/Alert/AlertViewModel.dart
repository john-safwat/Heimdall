import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/UseCase/GetNotificationsListUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/AlertNavigator.dart';

class AlertViewModel extends BaseViewModel<AlertNavigator> {

  GetNotificationsListUseCase getNotificationsListUseCase;
  AlertViewModel({required this.getNotificationsListUseCase});

  String?errorMessage;
  List<Notification> notifications = [];
  bool loading = true;

  loadNotifications()async{
    errorMessage = null;
    notifications = [];
    loading = true;
    notifyListeners();
    try{
      notifications = await getNotificationsListUseCase.invoke(lockId: "n197o0uVQ1WLANpSG5yH1VnxSKn1");
      loading = false;
      notifyListeners();
    }catch(e){
      errorMessage = handleErrorMessage(e as Exception);
      loading = false;
      notifyListeners();
    }
  }

  // function to get the animation
  String getAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/emptyBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/emptyPurple.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/emptyDarkPurple.json";
    }else {
      return "assets/animations/emptyBlue.json";
    }
  }

}