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
                    children: [
                      Expanded(child: value.tabs[value.selectedIndex])
                    ],
                  ),
                  bottomNavigationBar: NavigationBar(
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysShow,
                    height: 65,
                    overlayColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    selectedIndex: viewModel.selectedIndex,
                    onDestinationSelected: (index) => value.changeIndex(index),
                    backgroundColor: Theme.of(context).primaryColor,
                    indicatorColor: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.25),
                    destinations: [
                      NavigationDestination(
                          icon: Icon(EvaIcons.home_outline,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          selectedIcon: Icon(EvaIcons.home,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          label: viewModel.local!.locks),
                      NavigationDestination(
                          icon: Icon(Icons.key_outlined,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          selectedIcon: Icon(Icons.key,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          label: viewModel.local!.keys),
                      NavigationDestination(
                          icon: Icon(EvaIcons.message_square_outline,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          selectedIcon: Icon(EvaIcons.message_square,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          label: viewModel.local!.chat),
                      NavigationDestination(
                          icon: Icon(EvaIcons.bell_outline,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          selectedIcon: Icon(EvaIcons.bell,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          label: viewModel.local!.alerts),
                      NavigationDestination(
                        icon: Icon(EvaIcons.person_outline,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        selectedIcon: Icon(EvaIcons.person,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        label: viewModel.local!.profile,
                      ),
                    ],
                  ),
                ),
              )),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}
