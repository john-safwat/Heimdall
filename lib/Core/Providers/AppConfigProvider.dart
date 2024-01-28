// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {

  User? user;
  AppConfigProvider({this.user});

  void updateUser({required User user}){
    this.user = user;
    print("From app config provider");
    print(this.user!.displayName);
    notifyListeners();
  }

  User? getUser(){
    return user!;
  }

}