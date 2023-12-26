import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Firebase/FirebaseFeedbackDatabase.dart';
import 'package:heimdall/Data/Models/Feedback/FeedbackDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseFeedbackRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';


FirebaseFeedbackRemoteDataSource injectFirebaseFeedbackRemoteDataSource(){
  return FirebaseFeedbackRemoteDataSourceImpl(database: injectFirebaseFeedbackDatabase());
}

class FirebaseFeedbackRemoteDataSourceImpl extends FirebaseFeedbackRemoteDataSource {
  FirebaseFeedbackDatabase database;
  FirebaseFeedbackRemoteDataSourceImpl({required this.database});

  @override
  Future<String> sendFeedback({required FeedbackDTO feedback}) async{
    try {
      var response = await database.addFeedback(feedback: feedback).timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      throw FirebaseDatabaseException(errorMessage: e.code);
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

  @override
  Future<void> deleteUserFeedbacks({required String uid}) async {
    try {
      await database.deleteUserFeedbacks(uid: uid).timeout(const Duration(seconds: 60));
    } on FirebaseException catch (e) {
      throw FirebaseDatabaseException(errorMessage: e.code);
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }


}