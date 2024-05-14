import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';

UpdateRequestImageStateUseCase injectUpdateRequestImageStateUseCase(){
  return UpdateRequestImageStateUseCase(repository: injectLockRepository());
}

class UpdateRequestImageStateUseCase {

  LockRepository repository;
  UpdateRequestImageStateUseCase({required this.repository});

  Future<void> invoke({required String lockId , required bool state}) async {
    await repository.updateImageState(lockId: lockId, state: state);
  }


}