import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Firebase/FirebaseFeedbackDatabase.dart';
import 'package:heimdall/Data/Models/Feedback/FeedbackDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseFeedbackRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
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
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }


}