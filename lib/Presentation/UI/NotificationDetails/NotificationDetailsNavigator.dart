import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';

abstract class NotificationDetailsNavigator extends BaseNavigator{
  goToLockDetailsScreen(LockCard lockCard);
  goToImagePreviewScreen({required String image , required String tag , required List<String> images});

}