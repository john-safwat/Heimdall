import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetLocksCarsUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksNavigator.dart';
class LocksViewModel extends BaseViewModel <LocksNavigator>{

  GetLocksCarsUseCase getLocksCarsUseCase;
  LocksViewModel({required this.getLocksCarsUseCase});
  TextEditingController searchController = TextEditingController();
  List<LockCard> lockCardsList = [];
  List<LockCard> allLocksCardList = [];
  bool loading = true;
  String? errorMessage;

  // function to load data fro
  loadCardsData()async{
    errorMessage = null;
    lockCardsList = [];
    allLocksCardList = [];
    loading = true;
    notifyListeners();
    try{
      allLocksCardList = await getLocksCarsUseCase.invoke(uid: appConfigProvider!.user!.uid);
      lockCardsList = copyList(allLocksCardList);
      loading = false;
      notifyListeners();
    }catch (e){
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }

  }

  // function to copy message
  List<LockCard> copyList(List<LockCard> cards){
    List<LockCard> newCardsList = [];
    for (int i = 0 ; i < cards.length ; i++){
      newCardsList.add(cards[i]);
    }
    return newCardsList;
  }

  // navigation function
  // function to go to configure lock screen
  goToConfigureLocScreen(){
    navigator!.goToConfigureLockScreen();
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

  onLockCardPress(LockCard card){
    navigator!.goToLockDetailsScreen(card);
  }

  // function to search in locks
  void search(){
    lockCardsList = allLocksCardList.where((element) => element.name.contains(searchController.text)).toList();
    if (lockCardsList.isEmpty){
      lockCardsList = allLocksCardList.where((element) => element.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
    }
    if (lockCardsList.isEmpty){
      lockCardsList = allLocksCardList.where((element) => element.name.toUpperCase().contains(searchController.text.toUpperCase())).toList();
    }
    if (searchController.text.isEmpty){
      lockCardsList = copyList(allLocksCardList);
    }
    notifyListeners();
  }

}