import 'package:heimdall/Domain/Models/Report/Report.dart';

class ReportDTO {
  String id;
  String message;
  String uid;
  String email;
  DateTime dateTime;

  ReportDTO(
      {required this.id,
        required this.message,
        required this.uid,
        required this.email,
        required this.dateTime});

  ReportDTO.fromFireStore(Map<String , dynamic> json):this(
    id : json["id"],
    message : json["message"],
    uid : json["uid"],
    email : json["email"],
    dateTime : json["dateTime"],
  );

  Map<String , dynamic> toFireStore(){
    return {
      "id" : id,
      "message" : message,
      "uid" : uid,
      "email" : email,
      "dateTime" : dateTime,
    };
  }

  Report toDomain(){
    return Report(id: id, message: message, uid: uid, email: email, dateTime: dateTime);
  }

}
