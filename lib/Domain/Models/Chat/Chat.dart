import 'package:heimdall/Data/Models/Chat/ChatDTO.dart';

class Chat {
  String messageID;
  String senderID;
  int dateTime;
  String messageContent;

  Chat({
    required this.messageID,
    required this.senderID,
    required this.dateTime,
    required this.messageContent,
  });

  ChatDTO toDataSource() {
    return ChatDTO(
      messageID: messageID,
      senderID: senderID,
      dateTime: dateTime,
      messageContent: messageContent,
    );
  }
}
