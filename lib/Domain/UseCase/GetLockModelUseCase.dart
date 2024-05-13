import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/ModelsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Model/Model.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';
import 'package:heimdall/Domain/Repository/ModelsRepository.dart';

GetLockModelUseCase injectGetLockModelUseCase() {
  return GetLockModelUseCase(
      lockRepository: injectLockRepository(),
      modelsRepository: injectModelsRepository());
}

class GetLockModelUseCase {
  ModelsRepository modelsRepository;
  LockRepository lockRepository;

  GetLockModelUseCase(
      {required this.lockRepository, required this.modelsRepository});

  Future<Model> invoke({required String lockId}) async {
    var lock = await lockRepository.getLockData(lockId: lockId);
    var model = await modelsRepository.getModel(modelId: lock.model);
    return model;
  }
}
