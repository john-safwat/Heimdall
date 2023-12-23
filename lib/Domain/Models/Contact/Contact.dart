import 'package:heimdall/Data/Models/Contact/ContactDTO.dart';

class Contact {
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

  Contact({
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

  ContactDTO toDataSource() {
    return ContactDTO(
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
