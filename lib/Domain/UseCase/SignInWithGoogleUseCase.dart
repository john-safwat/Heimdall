import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

SignInWithGoogleUseCase injectSignInWithGoogleUseCase(){
  return SignInWithGoogleUseCase(repository: injectUserRepository());
}

class SignInWithGoogleUseCase {

  UserRepository repository;
  SignInWithGoogleUseCase({required this.repository});

  Future<User> invoke()async{
    var response = await repository.signInWithGoogle();
    return response;
  }

}