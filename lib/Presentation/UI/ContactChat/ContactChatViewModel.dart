import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatNavigator.dart';

class ContactChatViewModel extends BaseViewModel<ContactChatNavigator> {


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