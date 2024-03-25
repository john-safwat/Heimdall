import 'dart:async';
import 'dart:io';

import 'package:heimdall/Data/Hive/HiveLocksDatabase.dart';
import 'package:heimdall/Data/Models/Card/HiveLockCardDTO.dart';
import 'package:heimdall/Domain/DataSource/HiveLockCardsLocalDataSource.dart';
import 'package:heimdall/Domain/Exceptions/HiveLocalDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:hive/hive.dart';

HiveLockCardsLocalDataSource injectHiveLockCardsLocalDataSource(){
  return HiveLockCardsLocalDataSourceImpl(database: injectHiveLocksDatabase());
}

class HiveLockCardsLocalDataSourceImpl implements HiveLockCardsLocalDataSource {

  HiveLocksDatabase database;
  HiveLockCardsLocalDataSourceImpl({required this.database});

  @override
  Future<void> addCards({required List<HiveLockCardDTO> cards}) async{
    try {
      await database.addCards(cards: cards).timeout(const Duration(seconds: 60));
    }on HiveError catch(e){
      throw HiveLocalDatabaseException();
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {// handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<List<LockCard>> getCards()async {
    try {
      var response = await database.getCards().timeout(const Duration(seconds: 60));
      return response.map((e) => e.toDomain()).toList();
    }on HiveError catch(e){
      throw HiveLocalDatabaseException();
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {// handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> deleteCards()async {
    try {
      await database.deleteCards().timeout(const Duration(seconds: 60));
    }on HiveError catch(e){
      throw HiveLocalDatabaseException();
    }on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException {// handle timeout exception
      throw TimeOutOperationsException(errorMessage: "Timeout");
    } catch (e){ // handle unknown exceptions
      throw UnknownException(errorMessage: e.toString());
    }
  }

}