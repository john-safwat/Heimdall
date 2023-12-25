import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

SignOutUserUseCase injectSignOutUserUseCase(){
  return SignOutUserUseCase(repository: injectUserRepository());
}

class SignOutUserUseCase {

  UserRepository repository;
  SignOutUserUseCase({required this.repository});

  Future<void> invoke()async{
    await repository.signOut();
  }

}