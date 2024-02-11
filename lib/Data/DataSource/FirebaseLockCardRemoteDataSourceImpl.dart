import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Firebase/FirebaseCardsDatabase.dart';
import 'package:heimdall/Data/Models/Card/LockCardDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockCardRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';


FirebaseLockCardRemoteDataSource injectFirebaseLockCardRemoteDataSource(){
  return FirebaseLockCardRemoteDataSourceImpl(database: injectFirebaseCardsDatabase());
}

class FirebaseLockCardRemoteDataSourceImpl implements FirebaseLockCardRemoteDataSource {
  FirebaseCardsDatabase database;
  FirebaseLockCardRemoteDataSourceImpl({required this.database});

  @override
  Future<void> addLock({required String uid, required LockCardDTO lockCard}) async{
    try {
      var response = await database.addLockCard(uid: uid , lockCard: lockCard).timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseAuthException catch (e){ // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
    } on FirebaseException catch (e) { // handle firebase exception in en of ar
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
  Future<List<LockCard>> getCardsList({required String uid})async{
    try {
      var response = await database.getCardsList(uid: uid).timeout(const Duration(seconds: 60));
      return response.map((e) => e.toDomain()).toList();
    } on FirebaseAuthException catch (e){ // handle firebase auth exception in en of ar
      throw FirebaseUserAuthException(errorMessage: e.code);
    } on FirebaseException catch (e) { // handle firebase exception in en of ar
      throw FirebaseDatabaseException(errorMessage: e.code);
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {// handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

}