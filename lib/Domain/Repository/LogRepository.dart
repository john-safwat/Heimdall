import 'package:heimdall/Domain/Models/Log/Log.dart';

abstract class LogRepository {

  Future<void> addLog({required Log log});
  Future<List<Log>> getAllLogs({required String lockId});

}