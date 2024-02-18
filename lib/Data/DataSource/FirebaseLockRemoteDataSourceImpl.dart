import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:heimdall/Data/Firebase/FirebaseLockDatabase.dart';
import 'package:heimdall/Data/Models/Lock/LockDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Lock/Lock.dart';

FirebaseLockRemoteDataSource injectFirebaseLockRemoteDataSource(){
  return FirebaseLockRemoteDataSourceImpl(database: injectFirebaseLockDatabase());
}

class FirebaseLockRemoteDataSourceImpl implements FirebaseLockRemoteDataSource {

  FirebaseLockDatabase database ;
  FirebaseLockRemoteDataSourceImpl({required this.database});

  @override
  Future<Lock> getLockData({required String lockId}) async{
    try{
      var response = await database.getLockData(lockId: lockId).timeout(const Duration(seconds: 60));
      return response.toDomain();
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
  Future<void> updateLock({required LockDTO lock}) async{
    try{
      await database.updateLock(lock: lock).timeout(const Duration(seconds: 60));
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