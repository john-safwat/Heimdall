import 'package:heimdall/Data/DataSource/FirebaseContactsRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseContactsRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/Repository/ContactsRepository.dart';


ContactsRepository injectContactsRepository(){
  return ContactsRepositoryImpl(contactsRemoteDataSource: injectFirebaseContactsRemoteDataSource());
}

class ContactsRepositoryImpl implements ContactsRepository {

  FirebaseContactsRemoteDataSource contactsRemoteDataSource;
  ContactsRepositoryImpl({required this.contactsRemoteDataSource});

  @override
  Future<bool> contactExist({required String firstUserUID, required String secondUserUID}) async{
    var response = await contactsRemoteDataSource.contactExist(firstUserUID: firstUserUID, secondUserUID: secondUserUID);
    return response;
  }

  @override
  Future<Contact> createNewContact({required Contact contact}) async{
    var response = await contactsRemoteDataSource.createNewContact(contact: contact.toDataSource());
    return response;
  }

  @override
  Stream<List<Contact>> getFirstUserContact({required String uid}) async*{
    var response = contactsRemoteDataSource.getFirstUserContact(uid: uid);
    var listOfContacts = await response.first;
    yield listOfContacts.map((e) => e.toDomain()).toList();
  }

  @override
  Stream<List<Contact>> getSecondUserContact({required String uid})async*{
    var response = await contactsRemoteDataSource.getSecondUserContact(uid: uid);
    var listOfContacts = await response.first;
    yield listOfContacts.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> deleteUserContacts({required String uid}) async{
    await contactsRemoteDataSource.deleteUserContacts(uid: uid);
  }

  @override
  Future<void> updateContact({required Contact contact})async {
    await contactsRemoteDataSource.updateContact(contact: contact.toDataSource());
  }


}