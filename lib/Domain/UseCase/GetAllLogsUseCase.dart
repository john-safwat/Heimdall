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
    return sortLogsByTime(response);
  }

  // Helper function to sort notifications by time
  List<Log> sortLogsByTime(List<Log> logs) {
    // Create a copy to avoid modifying the original list
    List<Log> sortedLogs = List.from(logs);

    // Sort using the 'time' property of Notification objects
    sortedLogs.sort((a, b) => a.timeOpened.compareTo(b.timeOpened));

    return sortedLogs.reversed.toList();
  }


}