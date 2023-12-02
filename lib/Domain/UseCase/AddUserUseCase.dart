import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

AddUserUseCase injectAddUserUseCase(){
  return AddUserUseCase(repository: injectUserRepository());
}

class AddUserUseCase {

  UserRepository repository;
  AddUserUseCase({required this.repository});

  Future<void> invoke({required MyUser user})async {
    await repository.createUserFirebaseDatabase(user: user);
  }

}