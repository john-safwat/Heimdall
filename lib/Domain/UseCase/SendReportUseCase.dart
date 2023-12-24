import 'package:heimdall/Data/Repository/ReportRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Report/Report.dart';
import 'package:heimdall/Domain/Repository/ReportRepository.dart';

SendReportUseCase injectSendReportUseCase(){
  return SendReportUseCase(repository: injectReportRepository());
}

class SendReportUseCase {

  ReportRepository repository;
  SendReportUseCase({required this.repository});

  Future<Report> invoke({required Report report})async{
    var response = await repository.sendReport(report: report);
    return response;
  }

}