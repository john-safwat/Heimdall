import 'package:heimdall/Data/Repository/KeysRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Repository/KeysRepository.dart';


GetLockKeysUseCase injectGetLockKeysUseCase(){
  return GetLockKeysUseCase(repository: injectKeysRepository());
}

class GetLockKeysUseCase {
  
  KeysRepository repository;
  GetLockKeysUseCase({required this.repository});

  Future<List<EKey>> invoke({required String lockId})async {
    var response = await repository.getLockKeys(lockId: lockId);
    return response;
  }

}