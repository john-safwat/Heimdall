import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/UseCase/DeleteUserAccountUseCase.dart';
import 'package:heimdall/Domain/UseCase/SignOutUserUseCase.dart';
import 'package:heimdall/Presentation/Models/Button/Button.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/ProfileNavigator.dart';

class ProfileViewModel extends BaseViewModel<ProfileNavigator> {
  SignOutUserUseCase signOutUserUseCase;
  DeleteUserAccountUseCase deleteUserAccountUseCase;

  ProfileViewModel(
      {required this.signOutUserUseCase,
      required this.deleteUserAccountUseCase});

  late List<Button> buttonsData;

  // function to set the buttons data
  setButtonsData() {
    buttonsData = [
      Button(
          id: 1,
          icon: "assets/SVG/passwordIcon.svg",
          title: local!.changePassword,
          description: local!.changePasswordDescription,
          onClickListener: goToChangePasswordScreen,
          color: const Color(0xffff9500)),
      Button(
          id: 1,
          icon: "assets/SVG/settingsIcon.svg",
          title: local!.setting,
          description: local!.settingsDescription,
          onClickListener: goToSettingScreen,
          color: const Color(0xff007aff)),
      Button(
          id: 2,
          icon: "assets/SVG/lockIcon.svg",
          title: local!.lockManagement,
          description: local!.lockManagementDescription,
          onClickListener: goToLockManagementScreen,
          color: const Color(0xff4cd964)),
      Button(
          id: 3,
          icon: "assets/SVG/personIcon.svg",
          title: local!.yourFeedBack,
          description: local!.feedBackDescription,
          onClickListener: goToFeedbackScreen,
          color: const Color(0xff34aadc)),
      Button(
          id: 4,
          icon: "assets/SVG/issueIcon.svg",
          title: local!.reportIssue,
          description: local!.reportDescription,
          onClickListener: goToReportIssueScreen,
          color: const Color(0xffff9500)),
      Button(
          id: 5,
          icon: "assets/SVG/aboutUsIcon.svg",
          title: local!.aboutUs,
          description: local!.aboutUsDescription,
          onClickListener: goToAboutUsScreen,
          color: const Color(0xff007aff)),
      Button(
          id: 6,
          icon: "assets/SVG/deleteAccountIcon.svg",
          title: local!.deleteAccount,
          description: local!.deleteAccountDescription,
          onClickListener: onDeleteAccountPress,
          color: const Color(0xFFF73645)),
      Button(
          id: 7,
          icon: "assets/SVG/signOutIcon.svg",
          title: local!.signOut,
          description: local!.signOurDescription,
          onClickListener: onSignOutPress,
          color: const Color(0xFFF73645))
    ];
  }

  // Function to sign out user
  onSignOutPress() {
    navigator!.showQuestionMessage(
        message: local!.areYouSureToExit,
        negativeActionTitle: local!.cancel,
        posActionTitle: local!.ok,
        posAction: signOut);
  }

  signOut() async {
    navigator!.showLoading(message: local!.loading);
    try {
      await signOutUserUseCase.invoke();
      navigator!.goBack();
      navigator!.goToLoginScreen();
    } catch (e) {
      navigator!.goBack();
      navigator!.showFailMessage(
        message: handleErrorMessage(e as Exception),
        posActionTitle: local!.tryAgain,
      );
    }
  }

  // Function to sign out user
  onDeleteAccountPress() {
    navigator!.showQuestionMessage(
        message: local!.areYouSureToDeleteAccount,
        negativeActionTitle: local!.cancel,
        posActionTitle: local!.ok,
        posAction: deleteAccount);
  }

  deleteAccount() async {
    navigator!.showLoading(message: local!.loading);
    try {
      await deleteUserAccountUseCase.invoke(uid: appConfigProvider!.user!.uid);
      navigator!.goBack();
      navigator!.goToLoginScreen();
    } catch (e) {
      navigator!.goBack();
      navigator!.showFailMessage(
        message: handleErrorMessage(e as Exception),
        posActionTitle: local!.tryAgain,
      );
    }
  }

  // function to return the icon of the app
  String getIcon() {
    if (themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme) {
      return "assets/images/appIcon2.png";
    } else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme) {
      return "assets/images/appIcon3.png";
    } else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme) {
      return "assets/images/appIcon4.png";
    } else {
      return "assets/images/appIcon5.png";
    }
  }

  // navigation function
  // function to go to update profile screen
  goToUpdateProfileScreen() {
    navigator!.goToUpdateProfileScreen();
  }

  // function to go to setting screen
  goToSettingScreen() {
    navigator!.goToSettingScreen();
  }

  // function to go to Feedback screen
  goToFeedbackScreen() {
    navigator!.goToFeedbackScreen();
  }

  // function to go to ReportIssue screen
  goToReportIssueScreen() {
    navigator!.goToReportIssueScreen();
  }

  // function to go to About Us screen
  goToAboutUsScreen() {
    navigator!.goToAboutUsScreen();
  }

  // function to go to Lock Management screen
  goToLockManagementScreen() {
    navigator!.goToLockManagementScreen();
  }

  // function to go to login screen
  goToLoginScreen() {
    navigator!.goToLoginScreen();
  }
  // function to go to Change Password screen
  goToChangePasswordScreen(){
    navigator!.goToChangePasswordScreen();
  }

}
