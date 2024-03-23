import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Providers/LocksProvider.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Data/Firebase/FirebaseMessagingDatabase.dart';
import 'package:heimdall/Presentation/UI/AboutUs/AboutUsView.dart';
import 'package:heimdall/Presentation/UI/ChangePassword/ChangePasswordView.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockView.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatView.dart';
import 'package:heimdall/Presentation/UI/CreateKey/ManageKeyView.dart';
import 'package:heimdall/Presentation/UI/Feedback/FeedbackVeiw.dart';
import 'package:heimdall/Presentation/UI/ForgetPassword/ForgetPasswordView.dart';
import 'package:heimdall/Presentation/UI/Gallery/GalleryView.dart';
import 'package:heimdall/Presentation/UI/Home/HomeView.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewView.dart';
import 'package:heimdall/Presentation/UI/Intro/IntroView.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/KeyDetailsView.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsView.dart';
import 'package:heimdall/Presentation/UI/LockManagement/LockManagementView.dart';
import 'package:heimdall/Presentation/UI/Login/LoginView.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/NotificationDetailsView.dart';
import 'package:heimdall/Presentation/UI/Registration/RegistrationView.dart';
import 'package:heimdall/Presentation/UI/ReportIssue/ReportIssueView.dart';
import 'package:heimdall/Presentation/UI/Setting/SettingView.dart';
import 'package:heimdall/Presentation/UI/Splash/SplashScreen.dart';
import 'package:heimdall/Presentation/UI/UpdateProfile/UpdateProfileView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async{

  // block the code building for the loading of data
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // call shared pref to get some value
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var firstTime = prefs.getBool("firstTime");
  var loggedIn = prefs.getBool("loggedIn");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingDatabase.initFirebaseMessaging();
  User? user = FirebaseAuth.instance.currentUser;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
        ChangeNotifierProvider(create: (context) => LocalProvider(),),
        ChangeNotifierProvider(create: (context) => AppConfigProvider(user: user),),
        ChangeNotifierProvider(create: (context) => LocksProvider.getInstance(),)
      ],
      child: MyApp(firstTime: firstTime, loggedIn: loggedIn, user: user,)
    )
  );

}

class MyApp extends StatelessWidget {

  bool? firstTime ;
  bool? loggedIn ;
  User? user;

  MyApp({required this.firstTime , required this.loggedIn , required this.user ,super.key});

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
        SplashScreen.routeName : (context) => SplashScreen(firstTime: firstTime??true , loggedIn: loggedIn??false, user: user,),
        IntroView.routeName : (context) => const IntroView(),
        LoginView.routeName : (context) => const LoginView(),
        RegistrationView.routeName : (context) => const RegistrationView(),
        ForgetPasswordView.routeName : (context) => const ForgetPasswordView(),
        HomeView.routeName : (context) => const HomeView(),
        ContactChatView.routeName : (context) =>ContactChatView(),
        SettingView.routeName : (context) => const SettingView(),
        FeedbackView.routeName : (context) => const FeedbackView(),
        ReportIssueView.routeName : (context) => const ReportIssueView(),
        AboutUsView.routeName : (context) => const AboutUsView(),
        LockManagementView.routeName : (context) => const LockManagementView(),
        UpdateProfileView.routeName : (context) => const UpdateProfileView(),
        ChangePasswordView.routeName : (context) => const ChangePasswordView(),
        ConfigureLockView.routeName : (context) => const ConfigureLockView(),
        LockDetailsView.routeName : (context) => LockDetailsView(),
        ImagePreviewView.routeName : (context) => ImagePreviewView(),
        GalleryView.routeName : (context) => GalleryView(),
        NotificationDetailsView.routeName : (context) => NotificationDetailsView(),
        ManageKeyView.routeName : (context) => ManageKeyView(),
        KeyDetailsView.routeName : (context) => KeyDetailsView()
      },
      // the initial route to start the program from
      home: SplashScreen(firstTime:firstTime??true , loggedIn: loggedIn??false,user: user ),
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
