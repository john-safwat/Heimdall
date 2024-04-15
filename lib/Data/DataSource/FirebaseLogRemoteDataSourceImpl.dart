import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Firebase/FirebaseLogDatabase.dart';
import 'package:heimdall/Data/Models/Log/LogDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLogRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Log/Log.dart';

FirebaseLogRemoteDataSource injectFirebaseLogRemoteDataSource(){
  return FirebaseLogRemoteDataSourceImpl(database: injectFirebaseLogDatabase());
}

class FirebaseLogRemoteDataSourceImpl implements FirebaseLogRemoteDataSource{
  FirebaseLogDatabase database;
  FirebaseLogRemoteDataSourceImpl({required this.database});

  @override
  Future<void> addLog({required LogDTO log}) async{
    try {
      await database
          .addLog(log: log)
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
  Future<List<Log>> getAllLogs({required String lockId}) async{
    try {
      var response = await database
          .getAllLogs(lockId: lockId)
          .timeout(const Duration(seconds: 60));
      return response.map((e) => e.toDomain()).toList();
    } on FirebaseException catch (e) {
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      print(e);
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

}