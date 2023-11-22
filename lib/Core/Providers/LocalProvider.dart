import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier {

  // set the default local
  String _currentLocal = "en";

  // function to change the local with new local and set it in
  Future<void> changeLocal(String newLocal)async{

    // if the new local is the same this condition will terminate
    if(newLocal == _currentLocal) {return;}

    // reed the shared preferences to read the old value of the theme
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentLocal = newLocal;
    prefs.setString("local", _currentLocal);

    // notify all listeners on the theme values
    notifyListeners();
  }

  // if the language is english
  bool isEn(){
    return _currentLocal == "en";
  }

  // function to return the local
  String getLocal(){
    return _currentLocal;
  }

}