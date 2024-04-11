import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Chat/ChatDTO.dart';
abstract class FirebaseChatRemoteDataSource {
  Future<void> sendMessage({required ChatDTO chat,required String contactId});
  Stream<QuerySnapshot<ChatDTO>> getMessages({required String contactId});
}