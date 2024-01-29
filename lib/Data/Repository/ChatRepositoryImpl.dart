import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/DataSource/FirebaseChatRemoteDataSourceImpl.dart';
import 'package:heimdall/Data/Models/Chat/ChatDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseChatRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Chat/Chat.dart';
import 'package:heimdall/Domain/Repository/ChatRepository.dart';

ChatRepository injectChatRepository(){
  return ChatRepositoryImpl(remoteDataSource: injectFirebaseChatRemoteDataSource());
}

class ChatRepositoryImpl implements ChatRepository {

  FirebaseChatRemoteDataSource remoteDataSource;
  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> sendMessage({required Chat chat,required contactId}) async{
    var response = await remoteDataSource.sendMessage(chat: chat.toDataSource(),contactId: contactId);
    return response;
  }

  @override
  Stream<QuerySnapshot<ChatDTO>> getMessages({required String contactId}) {
    return remoteDataSource.getMessages(contactId: contactId);
  }

  
}