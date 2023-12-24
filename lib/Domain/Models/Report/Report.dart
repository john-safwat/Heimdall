import 'package:heimdall/Data/Models/Report/ReportDTO.dart';

class Report {
  String id;
  String message;
  String uid;
  String email;
  DateTime dateTime;

  Report(
      {required this.id,
        required this.message,
        required this.uid,
        required this.email,
        required this.dateTime});

  ReportDTO toDataSource(){
    return ReportDTO(
        id: id,
        message: message,
        uid: uid,
        email: email,
        dateTime: dateTime
    );
  }
}
