import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';

abstract class ChatNavigator extends BaseNavigator {

  goToContactChatScreen(Contact contact);
  showAddContactModalBottomSheet();

}