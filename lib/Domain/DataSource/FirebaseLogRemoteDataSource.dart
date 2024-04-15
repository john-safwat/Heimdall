import 'package:heimdall/Data/Models/Log/LogDTO.dart';
import 'package:heimdall/Domain/Models/Log/Log.dart';

abstract class FirebaseLogRemoteDataSource {

  Future<void> addLog({required LogDTO log});
  Future<List<Log>> getAllLogs({required String lockId});

}