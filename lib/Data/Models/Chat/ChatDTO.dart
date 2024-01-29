import 'package:heimdall/Domain/Models/Chat/Chat.dart';
class ChatDTO {
  static const String collectionName = "Messages";
  String messageID;
  String senderID;
  int dateTime;
  String messageContent;

  ChatDTO(
      {required this.messageID,
        required this.senderID,
        required this.dateTime,
        required this.messageContent,
       });

  ChatDTO.fromFireStore(Map<String, dynamic> json)
      : this(
    messageID: json["messageID"],
    senderID: json["senderID"],
    dateTime: json["dateTime"],
    messageContent: json["messageContent"],
  );

  Map<String, dynamic> toFireStore() {
    return {
      "messageID": messageID,
      "senderID": senderID,
      "messageContent": messageContent,
      "dateTime" : dateTime,
    };
  }

  Chat toDomain() {
    return Chat(
        messageID: messageID,
        senderID: senderID,
        dateTime: dateTime,
        messageContent: messageContent,
       );
  }
}
