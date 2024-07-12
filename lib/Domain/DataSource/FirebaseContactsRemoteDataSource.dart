
import 'package:heimdall/Data/Models/Contact/ContactDTO.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';

abstract class FirebaseContactsRemoteDataSource {

  Future<bool> contactExist({required String firstUserUID , required String secondUserUID});
  Future<Contact> createNewContact({required ContactDTO contact});
  Stream<List<ContactDTO>>  getFirstUserContact({required String uid});
  Stream<List<ContactDTO>> getSecondUserContact({required String uid});
  Future<void> deleteUserContacts({required String uid});
  Future<void> updateContact({required ContactDTO contact});
}