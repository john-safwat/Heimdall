import 'package:heimdall/Data/Repository/ChatRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Chat/Chat.dart';
import 'package:heimdall/Domain/Repository/ChatRepository.dart';

SendMessageUseCase injectSendMessageUseCase(){
  return SendMessageUseCase(repository: injectChatRepository());
}

class SendMessageUseCase {

  ChatRepository repository;
  SendMessageUseCase({required this.repository});

  Future<void> invoke({required Chat chat,required contactId})async {
    await repository.sendMessage(chat: chat, contactId: contactId);
  }

}