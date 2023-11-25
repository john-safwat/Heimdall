import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoNavigator.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/ThemeSlider.dart';
import 'package:provider/provider.dart';

class ExtraInfoView extends StatefulWidget {
  static const String routeName = "ExtraInfo";

  MyUser user;
  ExtraInfoView({required this.user, super.key});

  @override
  State<ExtraInfoView> createState() => _ExtraInfoViewState();
}

class _ExtraInfoViewState extends BaseState<ExtraInfoView, ExtraInfoViewModel>
    implements ExtraInfoNavigator {
  @override
  void initState() {
    super.initState();
    viewModel!.user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<ExtraInfoViewModel>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              title: Text(value.local!.completeProfile),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Row(),
                    // hello user message
                    Text(
                      '${value.local!.hello} ${value.user.name.split(" ")[0]}',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const   SizedBox(height: 10,),
                    // we need to know more about you message
                    Text(
                      value.local!.weNeedToKnowMoreAboutYou,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    const   SizedBox(height: 20,),
                    // the button to open bottom sheet 
                    InkWell(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      onTap: value.showModalBottomSheet,
                      child: Container(
                        padding:const  EdgeInsets.all(20),
                        width:value.mediaQuery!.width * 0.7,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        // image and title
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10,),
                            SvgPicture.asset(value.getLogo()),
                            const SizedBox(height: 10,),
                            Text(value.local!.pickYourImage , style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).scaffoldBackgroundColor),)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    ThemeSwitch(),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  @override
  ExtraInfoViewModel? initViewModel() {
    return ExtraInfoViewModel();
  }


}
