import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';

GetLockPasswordUserCase injectGetLockPasswordUserCase(){
  return GetLockPasswordUserCase(repository: injectLockRepository());
}

class GetLockPasswordUserCase {

  LockRepository repository;

  GetLockPasswordUserCase({required this.repository});

  Future<String> invoke({required String lockId})async{
    var response = await repository.getLockPassword(lockId: lockId);
    return response;
  }

}