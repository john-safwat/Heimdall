import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:heimdall/Data/Firebase/FirebaseModelsDatabase.dart';
import 'package:heimdall/Domain/DataSource/FirebaseModelsRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Model/Model.dart';

FirebaseModelsRemoteDataSource injectFirebaseModelsRemoteDataSource(){
  return FirebaseModelsRemoteDataSourceImpl(database: injectFirebaseModelsDatabase());
}

class FirebaseModelsRemoteDataSourceImpl implements FirebaseModelsRemoteDataSource {

  FirebaseModelsDatabase database ;
  FirebaseModelsRemoteDataSourceImpl({required this.database});

  @override
  Future<Model> getModel({required String modelId}) async{
    try {
      var response =  await database
          .getModel(modelId: modelId)
          .timeout(const Duration(seconds: 60));
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

}