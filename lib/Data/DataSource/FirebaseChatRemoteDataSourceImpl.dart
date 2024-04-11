import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Firebase/FirebaseChatDatabase.dart';
import 'package:heimdall/Data/Models/Chat/ChatDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseChatRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';

FirebaseChatRemoteDataSource injectFirebaseChatRemoteDataSource(){
  return FirebaseChatRemoteDataSourceImpl(database: injectFirebaseChatDatabase());
}

class FirebaseChatRemoteDataSourceImpl extends FirebaseChatRemoteDataSource {
  FirebaseChatDatabase database;
  FirebaseChatRemoteDataSourceImpl({required this.database});

  @override
  Future<void>sendMessage({required ChatDTO chat,required String contactId}) async{
    try {
      await database.sendMessage(chat: chat, contactId: contactId).timeout(const Duration(seconds: 60));
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
  Stream<QuerySnapshot<ChatDTO>> getMessages({required String contactId}) {
    return database.getMessagesStream(contactId:contactId);
  }

  
}