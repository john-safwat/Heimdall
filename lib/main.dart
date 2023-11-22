import 'package:flutter/material.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/Login/LoginView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(),)
      ],
      child: MyApp()
    )
  );

}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // define the needed provider
  late ThemeProvider themeProvider;



  @override
  Widget build(BuildContext context) {

    themeProvider = Provider.of<ThemeProvider>(context);
    // set the theme on the last theme user used
    setTheme();

    return MaterialApp(
      // remove the red debug banner
      debugShowCheckedModeBanner: false,

      // define the application routes that hold all the
      routes: {
        LoginView.routeName : (context) => LoginView()
      },

      // the initial route to start the program from
      initialRoute: LoginView.routeName,
      theme: themeProvider.getTheme(),

    );

  }

  // function to set the theme in application start
  Future<void> setTheme()async{
    // call object of shared preferences and read the theme value
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString("theme");

    // validate on the theme value and update the theme on the last updated theme from user
    if(theme == "BlackAndWhite"){
      themeProvider.changeTheme(MyTheme.blackAndWhiteTheme);
    }else if(theme == "PurpleAndWhite"){
      themeProvider.changeTheme(MyTheme.purpleAndWhiteTheme);
    }else if(theme == "DarkPurpleTheme"){
      themeProvider.changeTheme(MyTheme.darkPurpleTheme);
    }else {
      themeProvider.changeTheme(MyTheme.darkBlueTheme);
    }
  }


}
