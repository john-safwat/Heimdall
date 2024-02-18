import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Firebase/FirebaseReportDatabase.dart';
import 'package:heimdall/Data/Models/Report/ReportDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseReportRemoteDataSource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:heimdall/Domain/Models/Report/Report.dart';

FirebaseReportRemoteDataSource injectFirebaseReportRemoteDataSource(){
  return FirebaseReportRemoteDataSourceImpl(dataBase: injectFirebaseReportDataBase());
}

class FirebaseReportRemoteDataSourceImpl implements FirebaseReportRemoteDataSource {

  FirebaseReportDatabase dataBase;
  FirebaseReportRemoteDataSourceImpl({required this.dataBase});

  @override
  Future<Report> sendReport({required ReportDTO report}) async{
    try{
      var response = await dataBase.sendReport(report: report).timeout(const Duration(seconds: 60));
      return response.toDomain();
    } on FirebaseException catch (e) {
      throw FirebaseDatabaseException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "User Auth Timed Out");
    } catch (e) {
      throw UnknownException(errorMessage: "Unknown Error");
    }
  }

}