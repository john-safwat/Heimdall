import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Firebase/FirebaseContactsDatabase.dart';
import 'package:heimdall/Data/Models/Contact/ContactDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseContactsRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/ContactExistException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';

FirebaseContactsRemoteDataSource injectFirebaseContactsRemoteDataSource() {
  return FirebaseContactsRemoteDataSourceImpl(
      database: injectFirebaseContactsDatabase());
}

class FirebaseContactsRemoteDataSourceImpl
    implements FirebaseContactsRemoteDataSource {
  FirebaseContactsDatabase database;

  FirebaseContactsRemoteDataSourceImpl({required this.database});

  @override
  Future<bool> contactExist(
      {required String firstUserUID, required String secondUserUID}) async {
    try {
      var response = await database
          .contactExist(
              firstUserUID: firstUserUID, secondUserUID: secondUserUID)
          .timeout(const Duration(seconds: 60));
      if (response) {
        throw ContactExistException();
      }
      return response;
    } on FirebaseException catch (e) {
      // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {
      // handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } on ContactExistException {
      throw ContactExistException();
    } catch (e) {
      // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<Contact> createNewContact({required ContactDTO contact}) async {
    try {
      var response = await database
          .createContact(contact: contact)
          .timeout(const Duration(seconds: 60));
      return response.toDomain();
    } on FirebaseException catch (e) {
      // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {
      // handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e) {
      // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<List<ContactDTO>> getFirstUserContact({required String uid}) async {
    try {
      var response = await database
          .getFirstUserContact(uid: uid)
          .timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {
      // handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e) {
      // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<List<ContactDTO>> getSecondUserContact({required String uid}) async {
    try {
      var response = await database
          .getSecondUserContact(uid: uid)
          .timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {
      // handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e) {
      // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }
}
