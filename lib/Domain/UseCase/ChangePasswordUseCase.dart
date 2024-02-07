import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

ChangePasswordUseCase injectChangePasswordUseCase() {
  return ChangePasswordUseCase(repository: injectUserRepository());
}

class ChangePasswordUseCase {
  UserRepository repository;

  ChangePasswordUseCase({required this.repository});

  Future<User> invoke(
      {required String password,
      required String newPassword,
      required String email}) async {
    var response = await repository.changePassword(
        password: password, newPassword: newPassword, email: email);
    return response;
  }
}
