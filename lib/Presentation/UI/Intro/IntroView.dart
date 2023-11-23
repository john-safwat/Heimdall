import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Intro/IntroNavigator.dart';
import 'package:heimdall/Presentation/UI/Intro/IntroViewModel.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroView extends StatefulWidget {

  static const String routeName = "Intro";

  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends BaseState<IntroView , IntroViewModel> implements IntroNavigator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages:[
          // pick Your Language
          PageViewModel(
              decoration: PageDecoration(
                titleTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
                bodyTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                ),
                imageFlex: 2,
                titlePadding: const EdgeInsets.all(20),
                bodyPadding: const EdgeInsets.symmetric(horizontal: 20),
                imagePadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              title: viewModel!.local!.yourLanguage,
              // title: "Welcome",
              bodyWidget: const LanguageSwitch(),
              image: Lottie.asset("Assets/Animations/language.json")
          ) ,
        ]
      ),
    );
  }

  @override
  IntroViewModel? initViewModel() {
    return IntroViewModel();
  }
}
