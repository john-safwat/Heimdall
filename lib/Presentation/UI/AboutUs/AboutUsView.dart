import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/AboutUs/AboutUsNavigator.dart';
import 'package:heimdall/Presentation/UI/AboutUs/AboutUsViewModel.dart';

import 'package:provider/provider.dart';

class AboutUsView extends StatefulWidget {
  static const String routeName = "AboutUs";
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends BaseState<AboutUsView , AboutUsViewModel> implements AboutUsNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Scaffold(
        appBar: AppBar(title: Text(viewModel!.local!.aboutUs),),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(viewModel!.local!.aboutUsFirstHeadline,style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(
                  height: 20,
                ),
                Text(viewModel!.local!.aboutUsFirstBodyText,style: Theme.of(context).textTheme.bodyMedium,),
                const SizedBox(
                  height: 10,
                ),
                Text(viewModel!.local!.aboutUsSecondBodyText,style: Theme.of(context).textTheme.bodyMedium,),
                const SizedBox(
                  height: 20,
                ),
                Text(viewModel!.local!.aboutUsSecondHeadline,style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(
                  height: 20,
                ),
                Text(viewModel!.local!.aboutUsThirdBodyText,style: Theme.of(context).textTheme.bodyMedium,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  AboutUsViewModel? initViewModel() {
    return AboutUsViewModel();
  }
}