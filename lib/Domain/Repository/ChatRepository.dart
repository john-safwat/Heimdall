import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Chat/ChatDTO.dart';
import 'package:heimdall/Domain/Models/Chat/Chat.dart';

abstract class ChatRepository {
  Future<void> sendMessage({required Chat chat,required contactId});
  Stream<QuerySnapshot<ChatDTO>> getMessages({required String contactId});
}