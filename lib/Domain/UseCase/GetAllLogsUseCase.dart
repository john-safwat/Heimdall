import 'package:heimdall/Data/Repository/LogRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Log/Log.dart';
import 'package:heimdall/Domain/Repository/LogRepository.dart';

GetAllLogsUseCase injectGetAllLogsUseCase(){
  return GetAllLogsUseCase(repository: injectLogRepository());
}

class GetAllLogsUseCase {

  LogRepository repository;
  GetAllLogsUseCase({required this.repository});

  Future<List<Log>> invoke({required String lockId}) async {
    var response =  await repository.getAllLogs(lockId: lockId);
    return response;
  }

}