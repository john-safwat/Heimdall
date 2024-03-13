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

  String? errorMessage;
  List<MyNotification> notifications = [];
  bool loading = true;

  loadNotifications() async {
    errorMessage = null;
    notifications = [];
    loading = true;
    notifyListeners();
    try {
      notifications = await getNotificationsListUseCase.invoke(
          lockId: "n197o0uVQ1WLANpSG5yH1VnxSKn1");
      notifications = notifications.map((e) {
        e.backgroundColor = getBackgroundColor(e.priority);
        e.icon = getIcon(e.priority);
        e.iconColor = getIconColor(e.priority);
        e = getTitle(e);
        return e;
      }).toList();
      loading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = handleErrorMessage(e as Exception);
      loading = false;
      notifyListeners();
    }
  }

  // function to get the animation
  String getAnimation() {
    if (themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme) {
      return "assets/animations/emptyBlack.json";
    } else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme) {
      return "assets/animations/emptyPurple.json";
    } else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme) {
      return "assets/animations/emptyDarkPurple.json";
    } else {
      return "assets/animations/emptyBlue.json";
    }
  }

  Color getBackgroundColor(String priority) {
    if (priority == "low") {
      return MyTheme.darkGreenBackground;
    } else if (priority == "average") {
      return MyTheme.orangeBackground;
    } else if (priority == "high") {
      return MyTheme.darkRedBackground;
    } else {
      return MyTheme.blueBackground;
    }
  }

  Color getIconColor(String priority) {
    if (priority == "low") {
      return MyTheme.darkGreen;
    } else if (priority == "average") {
      return MyTheme.orange;
    } else if (priority == "high") {
      return MyTheme.darkRed;
    } else {
      return MyTheme.blue;
    }
  }

  IconData getIcon(String priority) {
    if (priority == "low") {
      return EvaIcons.checkmark_circle;
    } else if (priority == "average") {
      return EvaIcons.alert_triangle;
    } else if (priority == "high") {
      return EvaIcons.alert_circle;
    } else {
      return EvaIcons.info;}
  }

  MyNotification getTitle(MyNotification notification) {
    if(notification.code == 101){
      notification.title = local!.code101;
      notification.body = local!.body101;
    }else if(notification.code == 102){
      notification.title = local!.code102;
      notification.body = local!.body102;
    }else if(notification.code == 103){
      notification.title = local!.code103;
      notification.body = local!.body103;
    }else if(notification.code == 104){
      notification.title = local!.code104;
      notification.body = local!.body104;
    }else if(notification.code == 105){
      notification.title = local!.code105;
      notification.body = local!.body105;
    }else if(notification.code == 106){
      notification.title = local!.code106;
      notification.body = local!.body106;
    }else if(notification.code == 201){
      notification.title = local!.code201;
      notification.body = local!.body201;
    }else if(notification.code == 202){
      notification.title = local!.code202;
      notification.body = local!.body202;
    }else if(notification.code == 301){
      notification.title = local!.code301;
      notification.body = local!.body301;
    }else if(notification.code == 302){
      notification.title = local!.code302;
      notification.body = local!.body302;
    }
    return notification;
  }

  goToNotificationDetailsScreen(MyNotification notification) {}


}
