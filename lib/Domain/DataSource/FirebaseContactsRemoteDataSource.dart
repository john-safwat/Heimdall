
import 'package:heimdall/Data/Models/Contact/ContactDTO.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';

abstract class FirebaseContactsRemoteDataSource {

  Future<bool> contactExist({required String firstUserUID , required String secondUserUID});
  Future<Contact> createNewContact({required ContactDTO contact});
  Future<List<ContactDTO>>  getFirstUserContact({required String uid});
  Future<List<ContactDTO>> getSecondUserContact({required String uid});
}