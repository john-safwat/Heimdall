import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:heimdall/Data/Firebase/FirebaseLockUserDatabase.dart';
import 'package:heimdall/Data/Models/Users/UserDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockUsersRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';

FirebaseLockUsersRemoteDataSource injectFirebaseLockUsersRemoteDataSource() {
  return FirebaseLockUsersRemoteDataSourceImpl(
      database: injectFirebaseLockUsersDatabase());
}

class FirebaseLockUsersRemoteDataSourceImpl
    implements FirebaseLockUsersRemoteDataSource {
  FirebaseLockUsersDatabase database;

  FirebaseLockUsersRemoteDataSourceImpl({required this.database});

  @override
  addLockUser({required String lockId, required UserDTO userDTO}) async {
    try {
      await database
          .addLockUser(lockId: lockId, userDTO: userDTO)
          .timeout(const Duration(seconds: 60));
    } on FirebaseException catch (e) {
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<bool> userExist({required String lockId, required String uid}) async {
    try {
      var response = await database
          .userExist(lockId: lockId, uid: uid)
          .timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<List<MyUser>> getAllUsers({required String lockId}) async {
    try {
      var response = await database
          .getAllUsers(lockId: lockId)
          .timeout(const Duration(seconds: 60));
      return response.map((e) => e.toDomain()).toList();
    } on FirebaseException catch (e) {
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<void> deleteUser({required String uid, required String lockId}) async{
    try {
      await database
          .deleteUser(uid: uid, lockId: lockId)
          .timeout(const Duration(seconds: 60));
    } on FirebaseException catch (e) {
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }
}
