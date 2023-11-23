import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Presentation/UI/Intro/IntroView.dart';
import 'package:heimdall/Presentation/UI/Login/LoginView.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {

  static const String routeName = "SplashScreen";
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return AnimatedSplashScreen(
      splash: Center(
        child: SizedBox(
          height: 300,
          child: SvgPicture.asset(themeProvider.getSplashLogo())
        ),
      ),
      nextScreen:const IntroView(),
      duration: 2000,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      splashIconSize: double.infinity,
      splashTransition: SplashTransition.scaleTransition,

    );
  }
}
