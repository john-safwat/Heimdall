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

}