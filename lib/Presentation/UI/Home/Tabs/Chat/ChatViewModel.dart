import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/UseCase/AddContactUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetContactsUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/Widgets/BottomSheetWidget.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  TextEditingController contactController = TextEditingController();

  AddContactUseCase addContactUseCase;
  GetContactsUseCase getContactsUseCase;

  ChatViewModel(
      {required this.addContactUseCase, required this.getContactsUseCase});

  List<Contact> allContacts = [];
  List<Contact> contacts = [];
  bool loading = false;
  String? errorMessage;

  StreamController<List<Contact>> contactsStream = StreamController<List<Contact>>();
  // function to load user rooms
  Stream<List<Contact>> loadContacts() async* {
    allContacts = [];
    contacts = [];
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      StreamSubscription<List<Contact>> contactsStreamSubscription = contactsStream.stream.listen(
        (listOfContacts) {
          allContacts= listOfContacts;
          contacts = copyList();
          loading = false;
          notifyListeners();
        },
      );
      yield allContacts;
    } catch (e) {
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }
  }

  // function to copy list to avoid any reference
  List<Contact> copyList() {
    List<Contact> copy = [];
    for (int i = 0; i < allContacts.length; i++) {
      copy.add(allContacts[i]);
    }
    return copy;
  }

  // function to search for games in the list of games
  search(String query) {
    // get the users if the first user name contain the query
    var users1 = allContacts.where((element) => element.firstUserName.toUpperCase().contains(query.toUpperCase())).toList();
    // remove the users with the id of the current user
    users1.removeWhere((element) => element.firstUserUID == appConfigProvider!.user!.uid);
    // get the users if the second user name contain the query
    var users2 = allContacts.where((element) => element.secondUserName.toUpperCase().contains(query.toUpperCase())).toList();
    // remove the users with the id of the current user
    users2.removeWhere((element) => element.secondUserUID == appConfigProvider!.user!.uid);

    contacts = [];
    contacts.addAll(users1);
    contacts.addAll(users2);
    contacts = sortByLastMessageTime(contacts);
    if(query.isEmpty){
      contacts = allContacts;
    }
    notifyListeners();
  }


  List<Contact> sortByLastMessageTime(List<Contact> contacts){
    for(int i = 0 ; i< contacts.length-1 ; i++){
      var swapped= false;
      for(int j = 0 ; j<contacts.length - i -1 ; j++ ){
        if(contacts[j].lastMessageTime < contacts[j+1].lastMessageTime){
          var temp = contacts[j];
          contacts[j] = contacts[j+1];
          contacts[j+1] = temp;
          swapped = true;
        }
      }
      if (swapped == false) {
        break;
      }
    }
    return contacts;
  }


  // function to Change The Icon Depending on the running theme
  String getNoChatAnimation() {
    if (themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme) {
      return "assets/animations/BlackAndWhite.json";
    } else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme) {
      return "assets/animations/DarkPurple.json";
    } else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme) {
      return "assets/animations/DarkPurple.json";
    } else {
      return "assets/animations/Gold.json";
    }
  }

  // function to add new contact
  addContact() async {
    if (contactController.text.isNotEmpty) {
      String? emailValidationMessage = emailValidation();
      if (emailValidationMessage == null) {
        navigator!.showLoading(message: local!.loading);
        try {
          await addContactUseCase.invoke(
              email: contactController.text,
              user: appConfigProvider!.getUser()!);
          navigator!.goBack();
          navigator!.showSuccessMessage(
            message: local!.contactAddedSuccessfully,
            posActionTitle: local!.ok,
            posAction: () {
              loadContacts();
              navigator!.goBack();
            },
          );
          contactController.text = "";
        } catch (e) {
          navigator!.goBack();
          navigator!.showFailMessage(
              message: handleErrorMessage(e as Exception),
              posActionTitle: local!.tryAgain);
        }
      } else {
        navigator!.showFailMessage(
            message: emailValidationMessage, posActionTitle: local!.tryAgain);
      }
    } else {
      navigator!.showFailMessage(
          message: local!.emailCantBeEmpty, posActionTitle: local!.tryAgain);
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
  goToContactChatScreen(Contact contact) {
    navigator!.goToContactChatScreen(contact);
  }

  // function to show modal bottom sheet to add new contact
  showAddContactBottomSheet() {
    navigator!.showCustomModalBottomSheet(widget: BottomSheetWidget(
      controller: contactController,
      hintTitle: local!.enterEmail,
      buttonTitle: local!.addContact,
      addContactFunction: addContact,
    ));
  }
}
