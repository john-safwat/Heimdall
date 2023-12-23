import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/UseCase/AddContactUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetContactsUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatNavigator.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  TextEditingController contactController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  AddContactUseCase addContactUseCase;
  GetContactsUseCase getContactsUseCase;
  ChatViewModel({required this.addContactUseCase, required this.getContactsUseCase});

  List<Contact> contacts = [];
  bool loading = false;
  String? errorMessage ;

  // function to load user rooms
  loadContacts()async{
    contacts = [];
    loading = true;
    errorMessage = null;
    notifyListeners();

    try{
      contacts = await getContactsUseCase.invoke(uid: appConfigProvider!.user!.uid);
      loading = false;
      notifyListeners();
    }catch(e){
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }

  }

  // function to add new contact
  addContact() async {
    if (contactController.text.isNotEmpty) {
      String? emailValidationMessage = emailValidation();
      if(emailValidationMessage == null){
        navigator!.showLoading(message: local!.loading);
        try {
          await addContactUseCase.invoke(email: contactController.text, user: appConfigProvider!.getUser()!);
          navigator!.goBack();
          navigator!.showSuccessMessage(message: local!.contactAddedSuccessfully , posActionTitle: local!.ok , posAction: () {
            loadContacts();
            navigator!.goBack();
          },);
          contactController.text = "";
        } catch (e) {
          navigator!.goBack();
          navigator!.showFailMessage(
              message: handleErrorMessage(e as Exception),
              posActionTitle: local!.tryAgain);
        }
      }else{
        navigator!.showFailMessage(
            message: emailValidationMessage,
            posActionTitle: local!.tryAgain);
      }
    }else {
      navigator!.showFailMessage(
          message: local!.emailCantBeEmpty,
          posActionTitle: local!.tryAgain);
    }
  }


  // validate on the email form
  String? emailValidation() {
    if (contactController.text.isEmpty) {
      return local!.emailCantBeEmpty;
    } else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(contactController.text)) {
      return local!.enterAValidEmail;
    }
    return null;
  }

  // navigation functions
  // function to go to contact chat screen
  goToContactChatScreen() {
    navigator!.goToContactChatScreen();
  }

  // function to show modal bottom sheet to add new contact
  showAddContactBottomSheet() {
    navigator!.showAddContactModalBottomSheet();
  }
}
