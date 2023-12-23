import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/Models/Button/Button.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Profile/ProfileNavigator.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileViewModel extends BaseViewModel<ProfileNavigator> {
  late List<Button> buttonsData = [
    Button(id: 1, icon: EvaIcons.settings, title: local!.setting, onClickListener: goToSettingScreen),
    Button(id: 2, icon: EvaIcons.settings, title: local!.setting, onClickListener: goToSettingScreen),
    Button(id: 3, icon: EvaIcons.settings, title: local!.setting, onClickListener: goToSettingScreen),
    Button(id: 4, icon: EvaIcons.settings, title: local!.setting, onClickListener: goToSettingScreen),
    Button(id: 5, icon: EvaIcons.settings, title: local!.setting, onClickListener: goToSettingScreen),
    Button(id: 6, icon: EvaIcons.settings, title: local!.setting, onClickListener: goToSettingScreen)
  ];

  // navigation function
  // function to go to update profile screen
  goToUpdateProfileScreen() {}

  // function to go to setting screen
  goToSettingScreen() {
    navigator!.goToSettingScreen();
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
}
