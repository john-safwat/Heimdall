import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
abstract class LockManagementNavigator extends BaseNavigator{

  showOptionsModalBottomSheet({required LockCard card});
  goToEditLockScreen({required LockCard card});
  goToChangePasswordScreen(LockCard card);
  goToUsersListScreen(LockCard card);
  goToLogListScreen(LockCard card);
  goToLockInfoScreen(LockCard card);
  goToTripWireScreen(LockCard card);

}