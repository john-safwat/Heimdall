
import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';

abstract class RegistrationNavigator extends BaseNavigator {

  goToExtraInfoScreen(MyUser user);
  goToLoginScreen();

}