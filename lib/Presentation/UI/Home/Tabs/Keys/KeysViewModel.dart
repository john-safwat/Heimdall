import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/UseCase/GetKeysUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Keys/KeysNavigator.dart';

class KeysViewModel extends BaseViewModel<KeysNavigator>{

  GetKeysUseCase getKeysUseCase;
  KeysViewModel({required this.getKeysUseCase});


  TextEditingController searchController = TextEditingController();
  List<MyKey> keysList = [];
  List<MyKey> allKeysList = [];
  bool loading = true;
  String? errorMessage;

  // function to load data fro
  loadKeysData()async{
    errorMessage = null;
    allKeysList = [];
    keysList = [];
    loading = true;
    notifyListeners();
    try{
      allKeysList = await getKeysUseCase.invoke(uid: appConfigProvider!.user!.uid);
      keysList = copyList(allKeysList);
      loading = false;
      notifyListeners();
    }catch (e){
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }

  }

  // function to copy message
  List<MyKey> copyList(List<MyKey> cards){
    List<MyKey> newCardsList = [];
    for (int i = 0 ; i < cards.length ; i++){
      newCardsList.add(cards[i]);
    }
    return newCardsList;
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

  search() {
    keysList = allKeysList.where((element) => element.lockName.contains(searchController.text)).toList();
    if (keysList.isEmpty){
      keysList = allKeysList.where((element) => element.lockName.toLowerCase().contains(searchController.text.toLowerCase())).toList();
    }
    if (keysList.isEmpty){
      keysList = allKeysList.where((element) => element.lockName.toUpperCase().contains(searchController.text.toUpperCase())).toList();
    }
    if (searchController.text.isEmpty){
      keysList = copyList(allKeysList);
    }
    notifyListeners();
    
  }


  onCardClick(MyKey key){
    navigator!.goToKeyDetailsScreen(key);
  }

}