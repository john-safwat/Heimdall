
import 'package:heimdall/Data/Repository/ContactsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/Repository/ContactsRepository.dart';


GetContactsUseCase injectGetContactsUseCase(){
  return GetContactsUseCase(repository: injectContactsRepository());
}

class GetContactsUseCase {

  ContactsRepository repository ;
  GetContactsUseCase({required this.repository});

  Future<List<Contact>> invoke({required String uid})async{
    var firstUserContacts = await repository.getFirstUserContact(uid: uid);
    var secondContacts = await repository.getSecondUserContact(uid: uid);
    var response = sortByLastMessageTime(appendLists(firstUserContacts, secondContacts));
    return response;
  }

  List<Contact> appendLists(List<Contact> firstContacts , List<Contact> secondContact){
    for(int i =0 ; i<secondContact.length ; i++){
      firstContacts.add(secondContact[i]);
    }
    return firstContacts;
  }

  List<Contact> sortByLastMessageTime(List<Contact> contacts){
    for(int i = 0 ; i< contacts.length-1 ; i++){
      var swapped= false;
      for(int j = 0 ; j<contacts.length - i -1 ; j++ ){
        if(contacts[j].lastMessageTime > contacts[j+1].lastMessageTime){
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

}