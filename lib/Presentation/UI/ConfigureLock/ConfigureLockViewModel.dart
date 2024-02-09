
import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockNavigator.dart';

class ConfigureLockViewModel extends BaseViewModel <ConfigureLockNavigator> {

  String lockId = '3';
  String lockAvatar = "1";
  late TextEditingController nameController = TextEditingController(text: local!.setLockName);
  late Color cardColor = themeProvider!.getSecondaryColor();

  void readLockId(String? lockId){
    this.lockId = lockId??"";
    notifyListeners();
  }

}