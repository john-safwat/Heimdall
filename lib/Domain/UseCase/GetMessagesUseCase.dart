import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Chat/ChatDTO.dart';
import 'package:heimdall/Data/Repository/ChatRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/ChatRepository.dart';


GetMessagesUseCase injectGetMessagesUseCase(){
  return GetMessagesUseCase(repository: injectChatRepository());
}

class GetMessagesUseCase {

  ChatRepository repository;
  GetMessagesUseCase({required this.repository});

  Stream<QuerySnapshot<ChatDTO>> invoke({required String contactId}){
    return repository.getMessages(contactId:contactId);
  }
}