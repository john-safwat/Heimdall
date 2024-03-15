import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:heimdall/Data/Firebase/FirebaseMessagingDatabase.dart';
import 'package:heimdall/Domain/DataSource/FirebaseMessagingRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';


FirebaseMessagingRemoteDataSource injectFirebaseMessagingRemoteDataSource(){
  return FirebaseMessagingRemoteDataSourceImpl(database: injectFirebaseMessagingDatabase());
}

class FirebaseMessagingRemoteDataSourceImpl implements FirebaseMessagingRemoteDataSource{
  FirebaseMessagingDatabase database;
  FirebaseMessagingRemoteDataSourceImpl ({required this.database});

  @override
  Future<void> subscribeToTopic({required String lockId}) async{
    try {
      await database
          .subscribeToTopic(lockId: lockId)
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
  Future<void> unsubscribeFromTopic({required String lockId}) async{
    try {
      await database
          .unsubscribeFromTopic(lockId: lockId)
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