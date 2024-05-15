import 'dart:async';

import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';

GetTripwireParametersUseCase injectGetTripwireParametersUseCase() {
  return GetTripwireParametersUseCase(
      lockRepository: injectLockRepository());
}

class GetTripwireParametersUseCase {
  LockRepository lockRepository;

  GetTripwireParametersUseCase({required this.lockRepository});

  Future<(String, bool, (int , int , int , int) , int)> invoke({required String lockId}) async {
    var url = await lockRepository.getLastImage(lockId: lockId);
    var state = await lockRepository.getUpdateState(lockId: lockId);
    var points  = await lockRepository.getTripwirePoints(lockId: lockId);
    var timer  = await lockRepository.getTripwireTimer(lockId: lockId);
    return (url, state , points ,timer);
  }
}
