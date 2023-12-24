import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/Models/Button/Button.dart';
import 'package:heimdall/Presentation/UI/AboutUs/AboutUsView.dart';
import 'package:heimdall/Presentation/UI/Feedback/FeedbackVeiw.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/ProfileNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/ProfileViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/Widgets/CustomButton.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/Widgets/UserProfileDataWidget.dart';
import 'package:heimdall/Presentation/UI/LockManagement/LockManagementView.dart';
import 'package:heimdall/Presentation/UI/ReportIssue/ReportIssueView.dart';
import 'package:heimdall/Presentation/UI/Setting/SettingView.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

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
    viewModel!.buttonsData = [
      Button(
          id: 1,
          icon: EvaIcons.settings,
          title: viewModel!.local!.setting,
          onClickListener: viewModel!.goToSettingScreen,
          color: const Color(0xff007aff)),
      Button(
          id: 2,
          icon: EvaIcons.lock,
          title: viewModel!.local!.lockManagement,
          onClickListener: viewModel!.goToLockManagementScreen,
          color: const Color(0xff4cd964)),
      Button(
          id: 3,
          icon: EvaIcons.smiling_face_outline,
          title: viewModel!.local!.yourFeedBack,
          onClickListener: viewModel!.goToFeedbackScreen,
          color: const Color(0xff34aadc)),
      Button(
          id: 4,
          icon: EvaIcons.alert_triangle,
          title: viewModel!.local!.reportIssue,
          onClickListener: viewModel!.goToReportIssueScreen,
          color: const Color(0xffff9500)),
      Button(
          id: 5,
          icon: EvaIcons.alert_circle,
          title: viewModel!.local!.aboutUs,
          onClickListener: goToAboutUsScreen,
          color: const Color(0xff007aff)),
      Button(
          id: 6,
          icon: EvaIcons.trash,
          title: viewModel!.local!.deleteAccount,
          onClickListener: viewModel!.goToSettingScreen,
          color: const Color(0xFFF73645)),
      Button(
          id: 7,
          icon: EvaIcons.arrow_circle_right,
          title: viewModel!.local!.signOut,
          onClickListener: viewModel!.goToSettingScreen,
          color: const Color(0xFFF73645))
    ];
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Column(
        children: [
          UserProfileDataWidget(
              user: viewModel!.appConfigProvider!.user!,
              isEn: viewModel!.localProvider!.isEn(),
              buttonTitle: viewModel!.local!.edit,
              getIcon: viewModel!.getIcon,
              buttonAction: viewModel!.goToUpdateProfileScreen),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => CustomButton(button: viewModel!.buttonsData[index]),
              itemCount: viewModel!.buttonsData.length,
              separatorBuilder: (context, index) => const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(thickness: 1,),
              ),
            ),
          ),
        ],
      ),
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

  @override
  goToFeedbackScreen() {
    Navigator.pushNamed(context, FeedbackView.routeName);
  }

  @override
  goToReportIssueScreen() {
    Navigator.pushNamed(context, ReportIssueView.routeName);
  }

  @override
  goToAboutUsScreen() {
    Navigator.pushNamed(context, AboutUsView.routeName);
  }

  @override
  goToLockManagementScreen() {
    Navigator.pushNamed(context, LockManagementView.routeName);
  }
}
