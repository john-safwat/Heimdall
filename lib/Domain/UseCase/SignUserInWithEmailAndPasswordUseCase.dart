import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

SignUserInWithEmailAndPasswordUseCase injectSignUserInWithEmailAndPasswordUseCase(){
  return SignUserInWithEmailAndPasswordUseCase(repository: injectUserRepository());
}

class SignUserInWithEmailAndPasswordUseCase{

  UserRepository repository;
  SignUserInWithEmailAndPasswordUseCase({required this.repository});


  Future<User> invoke({required String local , required String email , required String password})async{
    var response = await repository.signInWithEmailAndPassword(local: local, email: email, password: password);
    return response;
  }

}