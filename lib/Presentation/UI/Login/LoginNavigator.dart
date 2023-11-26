import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';

abstract class LoginNavigator extends BaseNavigator{

  goToRegistrationScreen();
  goToForgetPasswordScreen();
  goToHomeScreen();
  goToExtraInfoScreen(MyUser user);

}