import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Firebase/FirebaseKeysDatabase.dart';
import 'package:heimdall/Data/Models/Key/KeyDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseKeysRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';


FirebaseKeysRemoteDataSource injectFirebaseKeysRemoteDataSource(){
  return FirebaseKeysRemoteDataSourceImpl(database: injectFirebaseKeysDatabase());
}

class FirebaseKeysRemoteDataSourceImpl implements FirebaseKeysRemoteDataSource{

  FirebaseKeysDatabase database;
  FirebaseKeysRemoteDataSourceImpl({required this.database});

  @override
  Future<void> createKey({required KeyDTO key}) async{
    try {
      await database.createKey(key: key).timeout(const Duration(seconds: 60));
    }on FirebaseException catch (e) { // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {// handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<List<MyKey>> getKeys({required String uid}) async{
    try {
      var response = await database.getKeys(uid: uid).timeout(const Duration(seconds: 60));
      return response.map((e) => e.toDomain()).toList();
    }on FirebaseException catch (e) { // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {// handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      print(e);
      throw UnknownException(errorMessage: e.toString());
    }
  }

}