import 'package:heimdall/Data/DataSource/FirebaseReportRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseReportRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Report/Report.dart';
import 'package:heimdall/Domain/Repository/ReportRepository.dart';


ReportRepository injectReportRepository(){
  return ReportRepositoryImpl(remoteDataSource: injectFirebaseReportRemoteDataSource());
}

class ReportRepositoryImpl implements ReportRepository {

  FirebaseReportRemoteDataSource remoteDataSource;
  ReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Report> sendReport({required Report report}) async{
    var response = await remoteDataSource.sendReport(report: report.toDataSource());
    return response;
  }

}