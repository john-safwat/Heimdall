import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';

abstract class LocksNavigator extends BaseNavigator {

  goToConfigureLockScreen();
  goToLockDetailsScreen(LockCard lockCard);

}