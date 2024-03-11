import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';

ChangeLockStateUseCase injectChangeLockStateUseCase(){
  return ChangeLockStateUseCase(repository: injectLockRepository());
}

class ChangeLockStateUseCase {

  LockRepository repository;
  ChangeLockStateUseCase({required this.repository});

  Future<void> invoke({required bool lockState})async {
    await repository.changeLockState(lockState: lockState);
  }

}