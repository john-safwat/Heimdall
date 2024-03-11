import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Firebase/FirebaseLockNotificationsDatabase.dart';
import 'package:heimdall/Data/Models/Notification/NotificationDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockNotificationsRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';

FirebaseLockNotificationsRemoteDataSource
    injectFirebaseLockNotificationsRemoteDataSource() {
  return FirebaseLockNotificationsRemoteDataSourceImpl(
      database: injectFirebaseLockNotificationsDatabase());
}

class FirebaseLockNotificationsRemoteDataSourceImpl
    implements FirebaseLockNotificationsRemoteDataSource {
  FirebaseLockNotificationsDatabase database;

  FirebaseLockNotificationsRemoteDataSourceImpl({required this.database});

  @override
  Future<List<Notification>> getNotificationsList(
      {required String lockId}) async {
    try {
      var response = await database
          .getNotificationsList(lockId: lockId)
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
  Future<void> addNotification({required NotificationDTO notification})async {
    try {
      await database
          .addNotification(notification: notification)
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
