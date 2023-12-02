import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

ResetPasswordUseCase injectResetPasswordUseCase(){
  return ResetPasswordUseCase(repository: injectUserRepository());
}

class ResetPasswordUseCase {

  UserRepository repository;
  ResetPasswordUseCase({required this.repository});

  Future<void> invoke ({required String email})async{
    await repository.resetPassword(email: email);
  }

}