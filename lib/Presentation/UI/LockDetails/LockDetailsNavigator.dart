import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';

abstract class LockDetailsNavigator extends BaseNavigator{

  goToImagePreviewScreen({required String image , required String tag , required List<String> images});
  goToGalleryScreen({required List<String> images});
  goToCreateKeyScreen({required LockCard lockCard});
  goToManageKeyScreen({required LockCard lockCard , required EKey eKey});
}