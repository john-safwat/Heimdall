import 'package:heimdall/Data/Repository/UserLockRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/UserLockRepository.dart';

GetLockUsersListUseCase injectGetLockUsersListUseCase(){
  return GetLockUsersListUseCase(repository: injectUserLockRepository());
}

class GetLockUsersListUseCase {

  UserLockRepository repository ;
  GetLockUsersListUseCase({required this.repository});


  Future<List<MyUser>> invoke({required String lockId })async {
    var response = await repository.getAllUsers(lockId: lockId);
    return response;
  }

}