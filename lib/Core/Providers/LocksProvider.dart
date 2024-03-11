import 'package:flutter/material.dart';


LocksProvider injectLocksProvider(){
  return LocksProvider.getInstance();
}

class LocksProvider extends ChangeNotifier {

  Map<dynamic, dynamic> value = {};
  String lockId= '';

  LocksProvider._();

  static LocksProvider? _instance;

  static LocksProvider getInstance() {
    return _instance ??= LocksProvider._();
  }

  updateValue(Map<dynamic, dynamic> data , String lockId){
    if(lockId != this.lockId){return;}
    value = data;
    notifyListeners();
  }

}