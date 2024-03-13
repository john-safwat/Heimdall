import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/UseCase/GetNotificationsListUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/NotificationsNavigator.dart';
import 'package:icons_plus/icons_plus.dart';

class NotificationsViewModel extends BaseViewModel<NotificationsNavigator> {

  GetNotificationsListUseCase getNotificationsListUseCase;
  NotificationsViewModel({required this.getNotificationsListUseCase});

  String?errorMessage;
  List<MyNotification> notifications = [];
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

  goToNotificationDetailsScreen(MyNotification notification){

  }

  Color getBackgroundColor(String priority){
    if(priority == "low"){
      return MyTheme.darkGreenBackground;
    }else if(priority == "average"){
      return MyTheme.orangeBackground;
    }else if(priority == "high"){
      return MyTheme.darkRedBackground;
    }else {
      return MyTheme.blueBackground;
    }
  }

  Color getIconColor(String priority){
    if(priority == "low"){
      return MyTheme.darkGreen;
    }else if(priority == "average"){
      return MyTheme.orange;
    }else if(priority == "high"){
      return MyTheme.darkRed;
    }else {
      return MyTheme.blue;
    }
  }

  IconData getIcon(String priority){
    if(priority == "low"){
      return EvaIcons.info;
    }else if(priority == "average"){
      return EvaIcons.alert_triangle;
    }else if(priority == "high"){
      return EvaIcons.alert_circle;
    }else {
      return EvaIcons.checkmark_circle;
    }
  }
}