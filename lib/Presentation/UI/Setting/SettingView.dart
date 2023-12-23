import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Setting/SettingNavigator.dart';
import 'package:heimdall/Presentation/UI/Setting/SettingViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  static const String routeName = "setting";
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends BaseState<SettingView , SettingViewModel> implements SettingNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel!.changeSelectedIndex();
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Scaffold(
        appBar: AppBar(title: Text(viewModel!.local!.setting),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              CarouselSlider(
                options: CarouselOptions(
                  initialPage: viewModel!.selectedIndex,
                  height: 450.0,
                  scrollPhysics:const PageScrollPhysics(),
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.7,
                  onPageChanged: (index, reason) => viewModel!.changeTheme(index),
                ),
                items: viewModel!.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin:const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 2 , color: Theme.of(context).primaryColor)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(i, fit:  BoxFit.cover,)
                          ),
          
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(viewModel!.local!.language , style: Theme.of(context).textTheme.titleLarge,),
                  const LanguageSwitch(),
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  SettingViewModel? initViewModel() {
    return SettingViewModel();
  }
}
