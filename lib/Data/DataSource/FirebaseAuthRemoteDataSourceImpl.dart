import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Firebase/FirebaseAuthUserDatabase.dart';
import 'package:heimdall/Data/Models/Users/UserDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseAuthRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseLoginException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';

// dependency injection
FirebaseAuthRemoteDataSource injectFirebaseAuthRemoteDataSource() {
  return FirebaseAuthRemoteDataSourceImpl(
      authDatabase: injectFirebaseAuthUserDatabase());
}

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  FirebaseAuthUserDatabase authDatabase;

  FirebaseAuthRemoteDataSourceImpl({required this.authDatabase});

  // function to create user in firebase auth and handle any exception
  @override
  Future<User> createUser({required UserDTO user}) async {
    try {
      // send user data to database
      var response = await authDatabase
          .createUser(user: user)
          .timeout(const Duration(seconds: 60));
      // return the response of the user
      return response;
    } on FirebaseAuthException catch (e) {
      // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
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

  // function to update user photo in user firebase auth
  @override
  Future<User> updateUserImage({required String image}) async {
    try {
      // send user data to database
      var response = await authDatabase
          .updateUserPhoto(image)
          .timeout(const Duration(seconds: 60));
      // return the response of the user
      return response;
    } on FirebaseAuthException catch (e) {
      // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
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
  Future<void> resetPassword({required String email}) async {
    try {
      await authDatabase
          .resetPassword(email: email)
          .timeout(const Duration(seconds: 60));
    } on FirebaseAuthException catch (e) {
      // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
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
  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var response = await authDatabase.signInUserWithEmailAndPassword(
          email: email, password: password);
      return response;
    } on FirebaseAuthException catch (e) {
      // handle firebase auth exception in en of ar
      throw FirebaseLoginException(errorMessage: e.code);
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
  Future<User> signInWithGoogle() async {
    try {
      var response = await authDatabase.signInWithGoogle();
      return response;
    } on FirebaseAuthException catch (e) {
      // handle firebase auth exception in en of ar
      throw FirebaseLoginException(errorMessage: e.code);
    } on FirebaseException catch (e) {
      // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {
      // handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e) {
      print(e);
      // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await authDatabase.deleteAccount();
    } on FirebaseAuthException catch (e) {
      // handle firebase auth exception in en of ar
      throw FirebaseLoginException(errorMessage: e.code);
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
  Future<void> signOut() async {
    try {
      await authDatabase.signOut();
    } on FirebaseAuthException catch (e) {
      // handle firebase auth exception in en of ar
      throw FirebaseLoginException(errorMessage: e.code);
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

  //update user display name
  @override
  Future<User> updateUserDisplayName({required String name}) async {
    try {
      // send user data to database
      var response = await authDatabase
          .updateUserDisplayName(name)
          .timeout(const Duration(seconds: 60));
      // return the response of the user
      return response;
    } on FirebaseAuthException catch (e) {
      // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
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
  Future<User> changePassword(
      {required String password,
      required String newPassword,
      required String email}) async {
    try {
      // send user data to database
      var response = await authDatabase
          .changePassword(password: password, newPassword: newPassword, email: email)
          .timeout(const Duration(seconds: 60));
      // return the response of the user
      return response;
    } on FirebaseAuthException catch (e) {
      // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
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
