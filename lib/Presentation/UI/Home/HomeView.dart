import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Home/HomeNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/HomeViewModel.dart';

class HomeView extends StatefulWidget {

  static const String routeName = "Home";

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView , HomeViewModel >implements HomeNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title :Text(viewModel!.local!.home),
      ),
    );
  }

  @override
  HomeViewModel? initViewModel() {
    return HomeViewModel();
  }
}
