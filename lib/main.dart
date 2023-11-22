import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/Login/LoginView.dart';

void main(){

  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginView.routeName : (context) => LoginView()
      },
      initialRoute: LoginView.routeName,
    );
  }
}
