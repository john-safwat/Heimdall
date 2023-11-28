import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Presentation/UI/Home/HomeNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/HomeViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:heimdall/Presentation/UI/Widgets/ThemeSlider.dart';
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
          body: Column(children: [
            LanguageSwitch(),
            ThemeSwitch()
          ],),
          bottomNavigationBar:FlashyTabBar(
            selectedIndex: viewModel!.selectedIndex,
            showElevation: false,
            onItemSelected: (index) => viewModel!.changeIndex(index),
            backgroundColor: Theme.of(context).primaryColor,
            height: 60,
            items: [
              FlashyTabBarItem(
                icon: Icon(EvaIcons.lock , color: Theme.of(context).scaffoldBackgroundColor, size: 30,),
                title: Text(viewModel!.local!.locks , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).scaffoldBackgroundColor),),
              ),
              FlashyTabBarItem(
                icon: Icon(FontAwesome.key , color: Theme.of(context).scaffoldBackgroundColor, size: 25,),
                title: Text(viewModel!.local!.keys , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).scaffoldBackgroundColor),),
              ),
              FlashyTabBarItem(
                icon: Icon(Bootstrap.chat_dots_fill , color: Theme.of(context).scaffoldBackgroundColor, size: 25),
                title: Text(viewModel!.local!.chat , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).scaffoldBackgroundColor),),
              ),
              FlashyTabBarItem(
                icon: Icon(EvaIcons.bell , color: Theme.of(context).scaffoldBackgroundColor, size: 25,),
                title: Text(viewModel!.local!.alerts , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).scaffoldBackgroundColor),),
              ),
              FlashyTabBarItem(
                icon: Icon(Bootstrap.person_circle , color: Theme.of(context).scaffoldBackgroundColor, size: 25,),
                title: Text(viewModel!.local!.profile , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).scaffoldBackgroundColor),),
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
