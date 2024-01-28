import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Data/Models/Chat/ChatDTO.dart';
import 'package:heimdall/Domain/Models/Chat/Chat.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/GetMessagesUseCase.dart';
import 'package:heimdall/Domain/UseCase/SendMessageUseCase.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatNavigator.dart';

class ContactChatViewModel extends BaseViewModel<ContactChatNavigator> {
  SendMessageUseCase sendMessageUseCase;
  GetMessagesUseCase getMessagesUseCase;
  ContactChatViewModel({required this.sendMessageUseCase,required this.getMessagesUseCase});
  List<Chat> chat = [];
  TextEditingController controller = TextEditingController();
  late Contact contact;
  String? errorMessage;

  // function to get messages in chat
  Stream<QuerySnapshot<ChatDTO>> loadChat(){
    return getMessagesUseCase.invoke(contactId: contact.contactId);
  }

  // function to send message
  sendMessage() async {
    if (controller.text.isNotEmpty){
      try {
        await sendMessageUseCase.invoke(
          chat: Chat(
            messageID: "",
            senderID: appConfigProvider!.user!.uid,
            dateTime: DateTime.now().millisecondsSinceEpoch,
            messageContent: controller.text,
          ),
          contactId: contact.contactId,
        );
        controller.text = "";
      } catch (e) {
        navigator!.showErrorNotification(message: local!.errorSendingMessage);
        notifyListeners();
      }
    }
  }

  // function to block contact
  blockContact() {
    //todo to be implemented
  }

  // function to block Contact
  removeContact() {
    //todo to be implemented
  }

  // navigation function
  showModalBottomSheet() {
    navigator!.showImagePickerModalBottomSheet();
  }
}
