
import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatNavigator.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {

  TextEditingController contactController = TextEditingController();
  TextEditingController searchController = TextEditingController();


  // function to add new contact
  addContact(){

  }

  // navigation functions
  // function to go to contact chat screen
  goToContactChatScreen(){
    navigator!.goToContactChatScreen();
  }

  // function to show modal bottom sheet to add new contact
  showAddContactBottomSheet(){
    navigator!.showAddContactModalBottomSheet();
  }

}