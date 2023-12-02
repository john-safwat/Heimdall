import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

CheckIfUserExistUseCase injectCheckIfUserExistUseCase(){
  return CheckIfUserExistUseCase(repository: injectUserRepository());
}

class CheckIfUserExistUseCase {

  UserRepository repository;
  CheckIfUserExistUseCase({required this.repository});

  Future<bool> invoke({required String uid})async{
    var response = await repository.checkIfUserExist( uid: uid);
    return response;
  }

}