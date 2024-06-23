import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Data/Models/Chat/ChatDTO.dart';
import 'package:heimdall/Domain/Models/Chat/Chat.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/UseCase/GetMessagesUseCase.dart';
import 'package:heimdall/Domain/UseCase/SendMessageUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateContactUseCase.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatNavigator.dart';
import 'package:heimdall/Presentation/UI/Widgets/ImagePIckLocationModalBottomSheetWidget.dart';

class ContactChatViewModel extends BaseViewModel<ContactChatNavigator> {
  SendMessageUseCase sendMessageUseCase;
  GetMessagesUseCase getMessagesUseCase;
  UpdateContactUseCase updateContactUseCase;

  ContactChatViewModel(
      {required this.sendMessageUseCase,
      required this.getMessagesUseCase,
      required this.updateContactUseCase});

  List<Chat> messages = [];
  TextEditingController controller = TextEditingController();
  late Contact contact;
  String? errorMessage;

  // function to get messages in chat
  Stream<QuerySnapshot<ChatDTO>> loadChat() {
    return getMessagesUseCase.invoke(contactId: contact.contactId);
  }

  // function to send message
  sendMessage() async {
    if (controller.text.isNotEmpty) {
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
        contact.lastMessage =controller.text ;
        contact.lastMessageTime = DateTime.now().millisecondsSinceEpoch;
        controller.text = "";
        notifyListeners();

        await updateContactUseCase.invoke(contact: contact);
      } catch (e) {
        navigator!.showErrorNotification(message: local!.errorSendingMessage);
        notifyListeners();
      }
    }
  }

  void sortMessagesByNewTime(){
    for(int i = 0 ; i< messages.length-1 ; i++){
      var swapped= false;
      for(int j = 0 ; j<messages.length - i -1 ; j++ ){
        if(messages[j].dateTime < messages[j+1].dateTime){
          var temp = messages[j];
          messages[j] = messages[j+1];
          messages[j+1] = temp;
          swapped = true;
        }
      }
      if (swapped == false) {
        break;
      }
    }
  }

  // function to block contact
  blockContact()async {
    if(contact.firstUserUID == appConfigProvider!.user!.uid){
      contact.isBlockedByFirstUser = true;
    }else{
      contact.isBlockedBySecondUser = true;
    }
    try {
      await updateContactUseCase.invoke(contact: contact);
      notifyListeners();
    } catch (e) {
      navigator!.showErrorNotification(message: local!.errorSendingMessage);
      notifyListeners();
    }
  }

  // function to block Contact
  removeContact() {
    //todo to be implemented
  }

  // navigation function
  showModalBottomSheet() {
    navigator!.showCustomModalBottomSheet(
        widget: ImagePickLocationModalBottomSheetWidget(
            title: local!.pickYourImagePickingMethod,
            cameraTitle: local!.camera,
            galleryTitle: local!.gallery,
            openCamera: pickImageFromCamera,
            openGallery: pickImageFromGallery));
  }

  unBlock()async {
    if(contact.firstUserUID == appConfigProvider!.user!.uid){
      contact.isBlockedByFirstUser = false;
    }else{
      contact.isBlockedBySecondUser = false;
    }
    try {
      await updateContactUseCase.invoke(contact: contact);
      notifyListeners();
    } catch (e) {
      navigator!.showErrorNotification(message: local!.errorSendingMessage);
      notifyListeners();
    }
  }
}
