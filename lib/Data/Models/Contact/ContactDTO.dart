import 'package:heimdall/Domain/Models/Contact/Contact.dart';

class ContactDTO {
  String contactId;
  String firstUserUID;
  String secondUserUID;
  String firstUserName;
  String secondUserName;
  String firstUserImage;
  String secondUserImage;
  String lastMessage;
  int lastMessageTime;
  bool lastMessageReadied;
  bool firstUserSentLastMessage;
  bool secondUserSentLastMessage;
  bool isBlockedByFirstUser;
  bool isBlockedBySecondUser;
  bool isRemovedFromFirstUser;
  bool isRemovedFromSecondUser;

  ContactDTO({
    required this.contactId,
    required this.firstUserUID,
    required this.secondUserUID,
    required this.firstUserName,
    required this.secondUserName,
    required this.firstUserImage,
    required this.secondUserImage,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageReadied,
    required this.firstUserSentLastMessage,
    required this.secondUserSentLastMessage,
    required this.isBlockedByFirstUser,
    required this.isBlockedBySecondUser,
    required this.isRemovedFromFirstUser,
    required this.isRemovedFromSecondUser,
  });

  ContactDTO.fromFireStore(Map<String, dynamic> json)
      : this(
            contactId: json["contactId"],
            firstUserUID: json["firstUserUID"],
            secondUserUID: json["secondUserUID"],
            firstUserName: json["firstUserName"],
            secondUserName: json["secondUserName"],
            firstUserImage: json["firstUserImage"],
            secondUserImage: json["secondUserImage"],
            lastMessage: json["lastMessage"],
            lastMessageTime: json["lastMessageTime"],
            lastMessageReadied: json["lastMessageReadied"],
            firstUserSentLastMessage: json["firstUserSentLastMessage"],
            secondUserSentLastMessage: json["secondUserSentLastMessage"],
            isBlockedByFirstUser: json["isBlockedByFirstUser"],
            isBlockedBySecondUser: json["isBlockedBySecondUser"],
            isRemovedFromFirstUser: json["isRemovedFromFirstUser"],
            isRemovedFromSecondUser: json["isRemovedFromSecondUser"]);

  Map<String, dynamic> toFireStore() {
    return {
      "contactId": contactId,
      "firstUserUID": firstUserUID,
      "secondUserUID": secondUserUID,
      "firstUserName": firstUserName,
      "secondUserName": secondUserName,
      "firstUserImage": firstUserImage,
      "secondUserImage": secondUserImage,
      "lastMessage": lastMessage,
      "lastMessageTime": lastMessageTime,
      "lastMessageReadied": lastMessageReadied,
      "firstUserSentLastMessage": firstUserSentLastMessage,
      "secondUserSentLastMessage": secondUserSentLastMessage,
      "isBlockedByFirstUser": isBlockedByFirstUser,
      "isBlockedBySecondUser": isBlockedBySecondUser,
      "isRemovedFromFirstUser": isRemovedFromFirstUser,
      "isRemovedFromSecondUser": isRemovedFromSecondUser
    };
  }

  Contact toDomain() {
    return Contact(
        contactId: contactId,
        firstUserUID: firstUserUID,
        secondUserUID: secondUserUID,
        firstUserName: firstUserName,
        secondUserName: secondUserName,
        firstUserImage: firstUserImage,
        secondUserImage: secondUserImage,
        lastMessage: lastMessage,
        lastMessageTime: lastMessageTime,
        lastMessageReadied: lastMessageReadied,
        firstUserSentLastMessage: firstUserSentLastMessage,
        secondUserSentLastMessage: secondUserSentLastMessage,
        isBlockedByFirstUser: isBlockedByFirstUser,
        isBlockedBySecondUser: isBlockedBySecondUser,
        isRemovedFromFirstUser: isRemovedFromFirstUser,
        isRemovedFromSecondUser: isRemovedFromSecondUser);
  }
}
