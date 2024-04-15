import 'package:heimdall/Data/DataSource/FirebaseLogRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLogRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Log/Log.dart';
import 'package:heimdall/Domain/Repository/LogRepository.dart';

LogRepository injectLogRepository(){
  return LogRepositoryImpl(remoteDataSource: injectFirebaseLogRemoteDataSource());
}

class LogRepositoryImpl implements LogRepository{

  FirebaseLogRemoteDataSource remoteDataSource;
  LogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addLog({required Log log}) async{
    await remoteDataSource.addLog(log: log.toDataSource());
  }

  @override
  Future<List<Log>> getAllLogs({required String lockId}) async{
    var response = await remoteDataSource.getAllLogs(lockId: lockId);
    return response;
  }

}