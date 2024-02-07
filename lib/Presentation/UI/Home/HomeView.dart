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
                    icon: Icon(Bootstrap.house),
                    activeIcon: Icon(Bootstrap.house_fill),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Icon(Bootstrap.key),
                    activeIcon: Icon(Bootstrap.key_fill),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Icon(Bootstrap.chat_left_text),
                    activeIcon: Icon(Bootstrap.chat_left_text_fill),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Icon(Bootstrap.bell),
                    activeIcon: Icon(Bootstrap.bell_fill),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Icon(Bootstrap.person),
                    activeIcon: Icon(Bootstrap.person_fill),
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
