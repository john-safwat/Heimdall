import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Firebase/FirebaseUserDatabase.dart';
import 'package:heimdall/Data/Models/Users/UserDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseUserDatabaseRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';

FirebaseUserDatabaseRemoteDataSource injectFirebaseUserDatabaseRemoteDataSource(){
  return FirebaseUserDatabaseRemoteDataSourceImpl(
      userDatabase: injectFirebaseUserDatabase(),
  );
}

class FirebaseUserDatabaseRemoteDataSourceImpl  implements FirebaseUserDatabaseRemoteDataSource {

  FirebaseUserDatabase userDatabase;
  FirebaseUserDatabaseRemoteDataSourceImpl({required this.userDatabase});

  // function to upload user data to database
  @override
  Future<void> createUserFirebaseDatabase({required UserDTO user}) async{
    try {
      var response = await userDatabase.createUser(user: user).timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseAuthException catch (e){ // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
    } on FirebaseException catch (e) { // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {// handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }



  // function to update user
  @override
  Future<void> updateUserProfile({required UserDTO user}) async{
    try {
      var response = await userDatabase.updateUserData(user: user).timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseAuthException catch (e){ // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
    } on FirebaseException catch (e) { // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {// handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserExist({required String uid}) async{
    try{
      var response = await userDatabase.userExist(uid: uid);
      return response;
    }on FirebaseAuthException catch (e){ // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
    } on FirebaseException catch (e) { // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {// handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }


}