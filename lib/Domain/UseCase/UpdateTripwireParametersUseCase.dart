import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';

UpdateTripwireParametersUseCase injectUpdateTripwireParametersUseCase(){
  return UpdateTripwireParametersUseCase(repository: injectLockRepository());
}

class UpdateTripwireParametersUseCase {
  LockRepository repository;

  UpdateTripwireParametersUseCase({required this.repository});

  Future<void> invoke(
      {required String lockId,
      required int x1,
      required int x2,
      required int y1,
      required int y2,
      required int timer}) async {
    await repository.updateTripwireParameters(
        lockId: lockId, x1: x1, x2: x2, y1: y1, y2: y2, timer: timer);
  }
}
