import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:heimdall/Data/Firebase/FirebaseLockRealTimeDatabase.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockRealtimeDatabaseRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';


FirebaseLockRealtimeDatabaseRemoteDataSource injectFirebaseLockRealtimeDatabaseRemoteDataSource(){
  return FirebaseLockRealtimeDatabaseRemoteDataSourceImpl(database: injectFirebaseLockRealTimeDatabase());
}

class FirebaseLockRealtimeDatabaseRemoteDataSourceImpl implements FirebaseLockRealtimeDatabaseRemoteDataSource{

  FirebaseLockRealTimeDatabase database;
  FirebaseLockRealtimeDatabaseRemoteDataSourceImpl({required this.database});

  @override
  setDatabaseReference({required String lockId}) {
    try{
      database.setDatabaseReference(lockId: lockId);
    }on FirebaseException catch (e) {
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
  Future<void> changeLockState({required bool lockState}) async{
    try{
      await database.changeLockState(lockState: lockState).timeout(const Duration(seconds: 60));
    }on FirebaseException catch (e) {
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