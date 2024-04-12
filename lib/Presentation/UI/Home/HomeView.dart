import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
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

class _HomeViewState extends BaseState<HomeView, HomeViewModel>
    implements HomeNavigator {

  @override
  void initState() {
    super.initState();
    viewModel.appInitialization();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) => SafeArea(
          child: Scaffold(
          
            body: Column(
              children: [Expanded(child: value.tabs[value.selectedIndex])],
            ),
          
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(EvaIcons.home_outline),
                    activeIcon: const Icon(EvaIcons.home),
                    label: viewModel.local!.locks
                ),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.key_outlined),
                    activeIcon: const Icon(Icons.key),
                    label: viewModel.local!.keys
                ),
                BottomNavigationBarItem(
                    icon: const Icon(EvaIcons.message_square_outline),
                    activeIcon: const Icon(EvaIcons.message_square),
                    label: viewModel.local!.chat
                ),
                BottomNavigationBarItem(
                    icon: const Icon(EvaIcons.bell_outline),
                    activeIcon: const Icon(EvaIcons.bell),
                    label: viewModel.local!.alerts
                ),
                BottomNavigationBarItem(
                    icon: const Icon(EvaIcons.person_outline),
                    activeIcon: const Icon(EvaIcons.person),
                    label: viewModel.local!.profile
                ),
              ],
              iconSize: 20,
              type: BottomNavigationBarType.fixed,
              currentIndex: value.selectedIndex,
              selectedItemColor: Theme.of(context).scaffoldBackgroundColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedIconTheme: const IconThemeData(size: 26),
              onTap: (index) => value.changeIndex(index),
            ),
          
          ),
        )
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

}
