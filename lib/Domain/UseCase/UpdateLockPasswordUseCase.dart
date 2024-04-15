import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';


UpdateLockPasswordUseCase injectUpdateLockPasswordUseCase(){
  return UpdateLockPasswordUseCase(repository: injectLockRepository());
}

class UpdateLockPasswordUseCase {

  LockRepository repository;
  UpdateLockPasswordUseCase({required this.repository});

  Future<void> invoke({required String lockId , required String password})async {
    await repository.updatePassword(lockId: lockId, password: password);

  }

}