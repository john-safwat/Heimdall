
import 'package:heimdall/Domain/Models/Report/Report.dart';

abstract class ReportRepository {

  Future<Report> sendReport({required Report report});

}