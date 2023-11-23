import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/Intro/IntroView.dart';
import 'package:heimdall/Presentation/UI/Login/LoginView.dart';
import 'package:heimdall/Presentation/UI/Splash/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main(){

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
        ChangeNotifierProvider(create: (context) => LocalProvider(),),
        ChangeNotifierProvider(create: (context) => AppConfigProvider(),)
      ],
      child: MyApp()
    )
  );

}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // define the needed provider
  late ThemeProvider themeProvider;
  late LocalProvider localProvider ;


  @override
  Widget build(BuildContext context) {

    themeProvider = Provider.of<ThemeProvider>(context);
    localProvider = Provider.of<LocalProvider>(context);

    // set the theme on the last theme user used
    setTheme();
    // set the language to the current language
    setLocal();

    return MaterialApp(
      // remove the red debug banner
      debugShowCheckedModeBanner: false,
      localizationsDelegates:const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale:Locale(localProvider.getLocal()),
      supportedLocales: AppLocalizations.supportedLocales,
      // define the application routes that hold all the
      routes: {
        SplashScreen.routeName : (context) => SplashScreen(),
        IntroView.routeName : (context) => IntroView(),
        LoginView.routeName : (context) => LoginView()
      },

      // the initial route to start the program from

      initialRoute: SplashScreen.routeName,
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

  // function to get the last set local
  Future<void> setLocal()async{
    // call object of shared preferences and read the theme value
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var local = prefs.getString("local");
    localProvider.changeLocal(local??="en");
  }

}
