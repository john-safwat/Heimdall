
import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';

SetLockRealTimeDatabaseListenerUseCase injectSetLockRealTimeDatabaseListenerUseCase(){
  return SetLockRealTimeDatabaseListenerUseCase(repository: injectLockRepository());
}

class SetLockRealTimeDatabaseListenerUseCase {

  LockRepository repository;
  SetLockRealTimeDatabaseListenerUseCase({required this.repository});

  invoke({required String lockId}){
    repository.setDatabaseReference(lockId: lockId);
  }

}