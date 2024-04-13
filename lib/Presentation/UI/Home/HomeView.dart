import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Home/HomeNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/HomeViewModel.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ion.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/uil.dart';
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
                          icon: Iconify(MaterialSymbols.lock_outline,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          selectedIcon: Iconify(MaterialSymbols.lock_open,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          label: viewModel.local!.locks),
                      NavigationDestination(
                          icon: Iconify(Mdi.key_chain,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          selectedIcon: Iconify(Mdi.key_chain,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          label: viewModel.local!.keys),
                      NavigationDestination(
                          icon: Icon(EvaIcons.messageSquareOutline,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          selectedIcon: Icon(EvaIcons.messageSquare,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          label: viewModel.local!.chat),
                      NavigationDestination(
                          icon: Icon(EvaIcons.bellOutline,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          selectedIcon: Icon(EvaIcons.bell,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          label: viewModel.local!.alerts),
                      NavigationDestination(
                        icon:Iconify(Uil.setting,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        selectedIcon: Iconify(Ion.settings,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        label: viewModel.local!.setting,
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
