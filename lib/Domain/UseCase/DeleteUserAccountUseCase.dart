import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';


DeleteUserAccountUseCase injectDeleteUserAccountUseCase(){
  return DeleteUserAccountUseCase(repository: injectUserRepository());
}

class DeleteUserAccountUseCase {

  UserRepository repository;
  DeleteUserAccountUseCase({required this.repository});

  Future<void> invoke({required String uid})async{
    await repository.deleteAccount(uid: uid);
  }

}