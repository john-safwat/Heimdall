
import 'package:heimdall/Domain/Models/Contact/Contact.dart';

abstract class ContactsRepository {

  Future<bool> contactExist({required String firstUserUID , required String secondUserUID});
  Future<Contact> createNewContact({required Contact contact});
  Future<List<Contact>>  getFirstUserContact({required String uid});
  Future<List<Contact>>  getSecondUserContact({required String uid});
  Future<void> deleteUserContacts({required String uid});
  Future<void> updateContact({required Contact contact});
}