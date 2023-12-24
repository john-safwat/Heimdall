import 'package:heimdall/Data/Models/Report/ReportDTO.dart';
import 'package:heimdall/Domain/Models/Report/Report.dart';

abstract class FirebaseReportRemoteDataSource {

  Future<Report> sendReport({required ReportDTO report});

}