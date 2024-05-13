import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Domain/UseCase/DeleteLockUseCase.dart';
import 'package:heimdall/Domain/UseCase/DeleteUserAccountUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetLocksCarsUseCase.dart';
import 'package:heimdall/Domain/UseCase/SignOutUserUseCase.dart';
import 'package:heimdall/Presentation/UI/AboutUs/AboutUsView.dart';
import 'package:heimdall/Presentation/UI/ChangePassword/ChangePasswordView.dart';
import 'package:heimdall/Presentation/UI/Feedback/FeedbackVeiw.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/ProfileNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/ProfileViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/Widgets/CustomButton.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/Widgets/UserProfileDataWidget.dart';
import 'package:heimdall/Presentation/UI/LockManagement/LockManagementView.dart';
import 'package:heimdall/Presentation/UI/Login/LoginView.dart';
import 'package:heimdall/Presentation/UI/ReportIssue/ReportIssueView.dart';
import 'package:heimdall/Presentation/UI/Setting/SettingView.dart';
import 'package:heimdall/Presentation/UI/UpdateProfile/UpdateProfileView.dart';
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
    viewModel.setButtonsData();
    viewModel.appConfigProvider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      body: ListView(

        children: [

          UserProfileDataWidget(
              user: viewModel.appConfigProvider!.getUser()!,
              isEn: viewModel.localProvider!.isEn(),
              buttonTitle: viewModel.local!.edit,
              getIcon: viewModel.getIcon,
              buttonAction: viewModel.goToUpdateProfileScreen),
          const SizedBox(height: 20,),
          Container(
            margin:const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                CustomButton(button: viewModel.buttonsData[1]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Divider(color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),),
                ),
                CustomButton(button: viewModel.buttonsData[0]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Divider(color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),),
                ),
                CustomButton(button: viewModel.buttonsData[2]),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            margin:const EdgeInsets.symmetric(horizontal: 15),

            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                CustomButton(button: viewModel.buttonsData[3]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Divider(color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),),
                ),
                CustomButton(button: viewModel.buttonsData[4]),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            margin:const EdgeInsets.symmetric(horizontal: 15),

            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                CustomButton(button: viewModel.buttonsData[5]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Divider(color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),),
                ),
                CustomButton(button: viewModel.buttonsData[6]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Divider(color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),),
                ),
                CustomButton(button: viewModel.buttonsData[7]),
              ],
            ),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  @override
  ProfileViewModel initViewModel() {
    return ProfileViewModel(
        signOutUserUseCase: injectSignOutUserUseCase(),
        deleteUserAccountUseCase: injectDeleteUserAccountUseCase(),
      getLocksCarsUseCase: injectGetLocksCarsUseCase(),
      deleteLockUseCase: injectDeleteLockUseCase()
    );
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

  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }

  @override
  goToUpdateProfileScreen() {
    Navigator.pushNamed(context, UpdateProfileView.routeName);
  }

  @override
  goToChangePasswordScreen() {
    Navigator.pushNamed(context, ChangePasswordView.routeName);
  }
}
