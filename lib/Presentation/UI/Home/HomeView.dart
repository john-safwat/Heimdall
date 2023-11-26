import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Presentation/UI/Home/HomeNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/HomeViewModel.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<HomeViewModel>(
        builder:(context, value, child) => Scaffold(
          appBar: AppBar(
            title :Text(viewModel!.local!.home),
          ),
          bottomNavigationBar:FlashyTabBar(
            selectedIndex: viewModel!.selectedIndex,
            showElevation: true,
            onItemSelected: (index) => viewModel!.changeIndex(index),
            items: [
              FlashyTabBarItem(
                icon: Icon(Icons.event),
                title: Text('Events'),
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.highlight),
                title: Text('Highlights'),
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.settings),
                title: Text('한국어'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel? initViewModel() {
    return HomeViewModel();
  }
}
