import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';

abstract class KeysNavigator extends BaseNavigator {

  goToKeyDetailsScreen(MyKey key);

}