import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/ProfileNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/ProfileViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/Widgets/UserProfileDataWidget.dart';
import 'package:heimdall/Presentation/UI/Setting/SettingView.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends BaseState<ProfileView, ProfileViewModel>
    implements ProfileNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        UserProfileDataWidget(
            user: viewModel!.appConfigProvider!.user!,
            isEn: viewModel!.localProvider!.isEn(),
            buttonTitle: viewModel!.local!.edit,
            getIcon: viewModel!.getIcon,
            buttonAction: viewModel!.goToUpdateProfileScreen),
        Expanded(
          child: ListView(
            padding:const EdgeInsets.all(20),
            children: [
              ElevatedButton(
                onPressed: viewModel!.goToSettingScreen,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Icon(EvaIcons.settings),
                      const SizedBox(width: 10,),
                      Text(viewModel!.local!.setting),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  ProfileViewModel? initViewModel() {
    return ProfileViewModel();
  }

  @override
  goToSettingScreen() {
    Navigator.pushNamed(context, SettingView.routeName);
  }
}
