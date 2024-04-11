import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Repository/ContactsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Exceptions/RecursiveChatUnAvailableException.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/Repository/ContactsRepository.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

AddContactUseCase injectAddContactUseCase() {
  return AddContactUseCase(
      userRepository: injectUserRepository(),
      contactsRepository: injectContactsRepository());
}

class AddContactUseCase {
  UserRepository userRepository;
  ContactsRepository contactsRepository;

  AddContactUseCase(
      {required this.userRepository, required this.contactsRepository});

  Future<Contact> invoke({required User user , required String email}) async {
    var response = await userRepository.getUserDataByEmail(email: email);
    if (response.uid == user.uid){
      throw RecursiveChatUnAvailableException();
    }
    await contactsRepository.contactExist(firstUserUID: user.uid, secondUserUID: response.uid);
    var contact = Contact(
        contactId: "none",
        firstUserUID: user.uid,
        secondUserUID: response.uid,
        firstUserName: user.displayName??"UnKnown",
        secondUserName: response.name,
        firstUserImage: user.photoURL??"",
        secondUserImage: response.image,
        lastMessage: "",
        lastMessageTime: DateTime.now().millisecondsSinceEpoch,
        lastMessageReadied: false,
        firstUserSentLastMessage: true,
        secondUserSentLastMessage: false,
        isBlockedByFirstUser: false,
        isBlockedBySecondUser: false,
        isRemovedFromFirstUser: false,
        isRemovedFromSecondUser: false);
    contact = await contactsRepository.createNewContact(contact: contact);
    return contact;
  }
}
