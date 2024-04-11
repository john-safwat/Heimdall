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
  Future<List<Contact>> getFirstUserContact({required String uid}) async{
    var response = await contactsRemoteDataSource.getFirstUserContact(uid: uid);
    return response.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Contact>> getSecondUserContact({required String uid})async{
    var response = await contactsRemoteDataSource.getSecondUserContact(uid: uid);
    return response.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> deleteUserContacts({required String uid}) async{
    await contactsRemoteDataSource.deleteUserContacts(uid: uid);
  }


}