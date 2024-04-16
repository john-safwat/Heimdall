import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetLocksCarsUseCase.dart';
import 'package:heimdall/Presentation/Models/Button/Button.dart';
import 'package:heimdall/Presentation/UI/LockManagement/LockManagementNavigator.dart';

class LockManagementViewModel extends BaseViewModel<LockManagementNavigator> {
  GetLocksCarsUseCase getLocksCarsUseCase;

  LockManagementViewModel({required this.getLocksCarsUseCase});

  TextEditingController searchController = TextEditingController();
  List<LockCard> lockCardsList = [];
  List<LockCard> allLocksCardList = [];
  bool loading = true;
  String? errorMessage;

  late List<Button> buttonsData = [
    Button(
        id: 1,
        icon: "assets/SVG/editLock.svg",
        title: local!.edit,
        description: "",
        onClickListener: goToEditLockScreen,
        color: const Color(0xffff9500)),
    Button(
        id: 2,
        icon: "assets/SVG/changePasswordIcon.svg",
        title: local!.password,
        description: "",
        onClickListener: goToChangePasswordScreen,
        color: const Color(0xffff9500)),
    Button(
        id: 3,
        icon: "assets/SVG/tripWire.svg",
        title: local!.tripwire,
        description: "",
        onClickListener: goToTripWireScreen,
        color: const Color(0xffff9500)),
    Button(
        id: 4,
        icon: "assets/SVG/lockUsers.svg",
        title: local!.users,
        description: "",
        onClickListener: goToUsersListScreen,
        color: const Color(0xffff9500)),
    Button(
        id: 5,
        icon: "assets/SVG/log.svg",
        title: local!.log,
        description: "",
        onClickListener: goToLogListScreen,
        color: const Color(0xffff9500)),
    Button(
        id: 6,
        icon: "assets/SVG/aboutUsIcon.svg",
        title: local!.info,
        description: "",
        onClickListener: goToAboutLockScreen,
        color: const Color(0xffff9500)),
    Button(
        id: 7,
        icon: "assets/SVG/deleteAccountIcon.svg",
        title: local!.delete,
        description: "",
        onClickListener: deleteLock,
        color: const Color(0xFFF73645)),
  ];


  goToEditLockScreen(LockCard card){
    navigator!.goBack();
    navigator!.goToEditLockScreen(card: card);
  }

  goToChangePasswordScreen(LockCard card){
    navigator!.goBack();
    navigator!.goToChangePasswordScreen(card);
  }
  goToTripWireScreen(LockCard card){

  }

  goToUsersListScreen(LockCard card){
    navigator!.goBack();
    navigator!.goToUsersListScreen(card);
  }
  goToLogListScreen(LockCard card){
    navigator!.goBack();
    navigator!.goToLogListScreen(card);
  }
  goToAboutLockScreen(LockCard card){

  }

  deleteLock(LockCard card){

  }


  // function to load data fro
  loadCardsData() async {
    errorMessage = null;
    lockCardsList = [];
    allLocksCardList = [];
    loading = true;
    notifyListeners();
    try {
      allLocksCardList =
          await getLocksCarsUseCase.invoke(uid: appConfigProvider!.user!.uid);
      lockCardsList = copyList(allLocksCardList);
      loading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }
  }

  // function to copy message
  List<LockCard> copyList(List<LockCard> cards) {
    List<LockCard> newCardsList = [];
    for (int i = 0; i < cards.length; i++) {
      newCardsList.add(cards[i]);
    }
    return newCardsList;
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

  onLockCardPress(LockCard card) {
    navigator!.showOptionsModalBottomSheet( card: card);
  }

  // function to search in locks
  void search() {
    lockCardsList = allLocksCardList
        .where((element) => element.name.contains(searchController.text))
        .toList();
    if (lockCardsList.isEmpty) {
      lockCardsList = allLocksCardList
          .where((element) => element.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }
    if (lockCardsList.isEmpty) {
      lockCardsList = allLocksCardList
          .where((element) => element.name
              .toUpperCase()
              .contains(searchController.text.toUpperCase()))
          .toList();
    }
    if (searchController.text.isEmpty) {
      lockCardsList = copyList(allLocksCardList);
    }
    notifyListeners();
  }
}
