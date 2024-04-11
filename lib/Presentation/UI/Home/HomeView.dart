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
              items: const[
                BottomNavigationBarItem(
                    icon: Icon(EvaIcons.home_outline),
                    activeIcon: Icon(EvaIcons.home),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.key_outlined),
                    activeIcon: Icon(Icons.key),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Icon(EvaIcons.message_square_outline),
                    activeIcon: Icon(EvaIcons.message_square),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Icon(EvaIcons.bell_outline),
                    activeIcon: Icon(EvaIcons.bell),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Icon(EvaIcons.person_outline),
                    activeIcon: Icon(EvaIcons.person),
                    label: ""
                ),
              ],
              iconSize: 20,
              type: BottomNavigationBarType.fixed,
              currentIndex: value.selectedIndex,
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
