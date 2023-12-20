import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatNavigator.dart';
enum SampleItem { itemOne, itemTwo }
class ContactChatViewModel extends BaseViewModel<ContactChatNavigator> {
  SampleItem? selectedMenu;

  changeSelectedItem(SampleItem item){
    selectedMenu = item;
    notifyListeners();
  }
  showModalBottomSheet(){
    navigator!.showImagePickerModalBottomSheet();
  }
}