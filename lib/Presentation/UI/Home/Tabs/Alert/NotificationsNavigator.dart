import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';

abstract class NotificationsNavigator extends BaseNavigator {

  goToNotificationDetailsScreen(MyNotification notification);
}