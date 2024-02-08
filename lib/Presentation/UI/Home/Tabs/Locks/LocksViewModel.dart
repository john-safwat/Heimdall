import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksNavigator.dart';

class LocksViewModel extends BaseViewModel <LocksNavigator>{

  TextEditingController searchController = TextEditingController();


  // navigation function
  // function to go to configure lock screen
  goToConfigureLocScreen(){
    navigator!.goToConfigureLockScreen();
  }

}