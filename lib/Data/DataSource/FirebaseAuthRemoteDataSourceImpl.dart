import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/ErrorHandler/FirebaseArabicErrorHandler.dart';
import 'package:heimdall/Data/ErrorHandler/FirebaseEnglishErrorHandler.dart';
import 'package:heimdall/Data/Firebase/FirebaseAuthUserDatabase.dart';
import 'package:heimdall/Data/Models/Users/UserDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseAuthRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';

// dependency injection
FirebaseAuthRemoteDataSource injectFirebaseAuthRemoteDataSource() {
  return FirebaseAuthRemoteDataSourceImpl(
      authDatabase: injectFirebaseAuthUserDatabase(),
      englishErrorHandler: injectFirebaseEnglishErrorHandler(),
      arabicErrorHandler: injectFirebaseArabicErrorHandler());
}

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  FirebaseAuthUserDatabase authDatabase;
  FirebaseArabicErrorHandler arabicErrorHandler;
  FirebaseEnglishErrorHandler englishErrorHandler;
  FirebaseAuthRemoteDataSourceImpl(
      {required this.authDatabase,
      required this.arabicErrorHandler,
      required this.englishErrorHandler});

  // function to create user in firebase auth and handle any exception
  @override
  Future<User> createUser({required String local, required UserDTO user}) async {
    try {
      // send user data to database
      var response = await authDatabase.createUser(user: user).timeout(const Duration(seconds: 60));
      // return the response of the user
      return response;
    } on FirebaseAuthException catch (e) { // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(
          errorMessage: local == "en"
              ? englishErrorHandler.handleFirebaseAuthException(error: e.code)
              : arabicErrorHandler.handleFirebaseAuthException(error: e.code));
    } on FirebaseException catch (e) { // handle firebase exception in en of ar
      throw FirebaseDatabaseException(
          errorMessage: local == "en"
              ? englishErrorHandler.handleFirebaseAuthException(error: e.code)
              : arabicErrorHandler.handleFirebaseAuthException(error: e.code)
      );
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException { // handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }


  // function to update user photo in user firebase auth
  @override
  Future<User> updateUserImage({required String local, required String image}) async{
    try {
      // send user data to database
      var response = await authDatabase.updateUserPhoto(image).timeout(const Duration(seconds: 60));
      // return the response of the user
      return response;
    } on FirebaseAuthException catch (e) { // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(
          errorMessage: local == "en"
              ? englishErrorHandler.handleFirebaseAuthException(error: e.code)
              : arabicErrorHandler.handleFirebaseAuthException(error: e.code));
    } on FirebaseException catch (e) { // handle firebase exception in en of ar
      throw FirebaseDatabaseException(
          errorMessage: local == "en"
              ? englishErrorHandler.handleFirebaseAuthException(error: e.code)
              : arabicErrorHandler.handleFirebaseAuthException(error: e.code)
      );
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException { // handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }
}
