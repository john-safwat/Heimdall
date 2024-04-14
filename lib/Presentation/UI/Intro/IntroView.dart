import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Intro/IntroNavigator.dart';
import 'package:heimdall/Presentation/UI/Intro/IntroViewModel.dart';
import 'package:heimdall/Presentation/UI/Login/LoginView.dart';
import 'package:heimdall/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:heimdall/Presentation/UI/Widgets/ThemeSlider.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class IntroView extends StatefulWidget {

  static const String routeName = "Intro";

  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends BaseState<IntroView , IntroViewModel> implements IntroNavigator {

  @override
  void initState() {
    super.initState();
    viewModel.appInitialization();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // decoration for all pages in this page view
    var pageDecoration =  PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.titleLarge!,
      bodyTextStyle: Theme.of(context).textTheme.bodyLarge!,
      imageFlex: 2,
      titlePadding: const EdgeInsets.all(20),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 20),
      imagePadding: const EdgeInsets.symmetric(horizontal: 20),
    );

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          body: IntroductionScreen(
            pages: [
              // set language page
              PageViewModel(
                decoration: pageDecoration,
                image: Lottie.asset(viewModel.getLocalAnimation()),
                title: viewModel.local!.yourLanguage,
                bodyWidget: const LanguageSwitch()
              ),
              // set theme page
              PageViewModel(
                  decoration: pageDecoration,
                  image: Lottie.asset("assets/animations/theme.json"),
                  title: viewModel.local!.makeItYourOwn,
                  bodyWidget: ThemeSwitch()
              ),
              // Welcome Message
              PageViewModel(
                  decoration: pageDecoration,
                  image: Lottie.asset(viewModel.getHelloAnimation()),
                  title: viewModel.local!.welcome,
                  body: viewModel.local!.welcomeMessage
              ),
              // security Message
              PageViewModel(
                  decoration: pageDecoration,
                  image: Lottie.asset(viewModel.getSecurityAnimation()),
                  title: viewModel.local!.yourSecurity,
                  body: viewModel.local!.yourSecurityMessage
              ),
              // security Message
              PageViewModel(
                  decoration: pageDecoration,
                  image: Lottie.asset(viewModel.getQRAnimation()),
                  title: viewModel.local!.qrCode,
                  body: viewModel.local!.qrCodeMessage
              ),
              // security Message
              PageViewModel(
                  decoration: pageDecoration,
                  image: Lottie.asset(viewModel.getChatAnimation()),
                  title: viewModel.local!.chatTitle,
                  body: viewModel.local!.chatMessage
              ),
              // security Message
              PageViewModel(
                  decoration: pageDecoration,
                  image: Lottie.asset(viewModel.getKeyAnimation()),
                  title: viewModel.local!.loginTitle,
                  body: viewModel.local!.loginMessage
              )
            ],
            done: Text(viewModel.local!.finish),
            next: Text(viewModel.local!.next),
            back: Text(viewModel.local!.back),
            backStyle: ButtonStyle(
                textStyle: MaterialStateProperty.all( Theme.of(context).textTheme.titleMedium),
                foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
            ) ,
            nextStyle:  ButtonStyle(
                textStyle: MaterialStateProperty.all( Theme.of(context).textTheme.titleMedium),
                foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
            ),
            doneStyle: ButtonStyle(
                textStyle: MaterialStateProperty.all( Theme.of(context).textTheme.titleMedium),
                foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
            ),
            dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: Theme.of(context).primaryColor,
              color: Theme.of(context).secondaryHeaderColor,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              ),
            ),
            showBackButton: true,
            onDone: viewModel.onDonePress,
          ),
        ),
      ),
    );
  }

  @override
  IntroViewModel initViewModel() {
    return IntroViewModel();
  }

  // function to navigate to login screen
  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }
}
