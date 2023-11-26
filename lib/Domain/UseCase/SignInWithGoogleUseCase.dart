import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

SignInWithGoogleUseCase injectSignInWithGoogleUseCase(){
  return SignInWithGoogleUseCase(repository: injectUserRepository());
}

class SignInWithGoogleUseCase {

  UserRepository repository;
  SignInWithGoogleUseCase({required this.repository});

  Future<User> invoke({required String local})async{
    var response = await repository.signInWithGoogle(local: local);
    return response;
  }

}