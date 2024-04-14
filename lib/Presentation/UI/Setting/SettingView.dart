import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _SettingViewState extends BaseState<SettingView, SettingViewModel>
    implements SettingNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.changeSelectedIndex();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.setting),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Theme.of(context).primaryColor),
                      color: Theme.of(context).primaryColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(50)),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/black.png",
                        width: double.infinity,
                      ),
                      Image.asset(
                        viewModel.getPreviewImage(),
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: viewModel.images
                        .map((i) => Expanded(
                              child: InkWell(
                                onTap: () {
                                  viewModel
                                      .changeTheme(viewModel.images.indexOf(i));
                                },
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      color: viewModel.images.indexOf(i) ==
                                              viewModel.selectedIndex
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          width: 2,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        i,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        viewModel.local!.language,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          viewModel.changeLocal("en");
                        },
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Radio(
                                value: "en",
                                activeColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                groupValue: viewModel.localProvider!.getLocal(),
                                onChanged: (value) {
                                  viewModel.changeLocal(value ?? "en");
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "English",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Divider(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.3),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          viewModel.changeLocal("ar");
                        },
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Radio(
                                value: "ar",
                                activeColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                groupValue: viewModel.localProvider!.getLocal(),
                                onChanged: (value) {
                                  viewModel.changeLocal(value ?? "en");
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "العربية",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  SettingViewModel initViewModel() {
    return SettingViewModel();
  }
}
