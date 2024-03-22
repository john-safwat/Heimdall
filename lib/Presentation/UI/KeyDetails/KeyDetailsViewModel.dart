import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Providers/LocksProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Models/Log/Log.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/UseCase/ChangeLockStateUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetLockImagesListUseCase.dart';
import 'package:heimdall/Domain/UseCase/SetLockRealTimeDatabaseListenerUseCase.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/KeyDetailsNavigator.dart';
import 'package:intl/intl.dart';

class KeyDetailsViewModel extends BaseViewModel<KeyDetailsNavigator> {
  EKey key;
  SetLockRealTimeDatabaseListenerUseCase setLockRealTimeDatabaseListenerUseCase;
  ChangeLockStateUseCase changeLockStateUseCase;

  late LocksProvider locksProvider;

  KeyDetailsViewModel(
      {required this.key,
      required this.setLockRealTimeDatabaseListenerUseCase,
      required this.changeLockStateUseCase});

  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  List<String> images = [];
  String? imagesErrorMessage;
  bool imagesLoading = true;
  bool lockLoading = true;
  String? lockErrorMessage;

  setDatabaseListener() async {
    lockErrorMessage = null;
    lockLoading = true;
    notifyListeners();
    try {
      await setLockRealTimeDatabaseListenerUseCase.invoke(
          lockId: key.lockId!);
      lockLoading = false;
      notifyListeners();
    } catch (e) {
      lockErrorMessage = handleErrorMessage(e as Exception);
      lockLoading = false;
      notifyListeners();
    }
  }

  changeLockState() async {
    if(validate()){
      if(authenticated){
        try {
          var data = locksProvider.value;
          await changeLockStateUseCase.invoke(
              lockState: !data["opened"],
              log: Log(
                  eventType: !data["opened"] ? "UnLock" : "Closed",
                  id: key.lockId!,
                  method: "Mobile",
                  timeOpened: DateTime.now().toUtc(),
                  uid: appConfigProvider!.user!.uid,
                  userName: appConfigProvider!.user!.displayName ?? "UnKnown"),
              notification: MyNotification(
                  id: key.lockId!,
                  code: !data["opened"]? 103:102,
                  body: !data["opened"]
                      ? "This Lock Is Opened Using Mobile App Successfully"
                      : "This Lock Is Closed Using Mobile App Successfully",
                  priority: "low",
                  time: DateTime.now().toUtc(),
                  urls: []));
          notifyListeners();
        } catch (e) {
          notifyListeners();
        }
      }else {
        await authenticateUser();
        if(authenticated){
          changeLockState();
        }
      }
    }
  }

  bool validate(){
    DateTime date = DateTime.now();
    TimeOfDay time = TimeOfDay.now();
    if(date.compareTo(key.startDate!) < 0){
      return false ;
    }else if (date.compareTo(key.endDate!) > 0 && !key.validOnce!){
      return false ;
    }else if(time.hour < key.startTime!.hour && time.minute < key.startTime!.minute){
      return false;
    }else if(time.hour > key.endTime!.hour && time.minute > key.endTime!.minute) {
      return false;
    }else if(!key.days!.contains(DateFormat("E").format(date)) && key.days!.isNotEmpty){
      return false;
    }
    return true;
  }

  // function to return the icon of the app
  String getIcon() {
    if (themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme) {
      return "assets/images/appIcon2.png";
    } else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme) {
      return "assets/images/appIcon3.png";
    } else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme) {
      return "assets/images/appIcon4.png";
    } else {
      return "assets/images/appIcon5.png";
    }
  }
}
