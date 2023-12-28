import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatNavigator.dart';

class ContactChatViewModel extends BaseViewModel<ContactChatNavigator> {

  late Contact contact;

  // function to block contact
  blockContact(){
    //todo to be implemented
  }

  // function to block Contact
  removeContact(){
    //todo to be implemented
  }


  // navigation function
  showModalBottomSheet(){
    navigator!.showImagePickerModalBottomSheet();
  }
}