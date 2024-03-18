import 'package:heimdall/Data/Repository/KeysRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Repository/KeysRepository.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

CreateKeyUseCase injectCreateKeyUseCase() {
  return CreateKeyUseCase(
      repository: injectKeysRepository(),
      userRepository: injectUserRepository());
}

class CreateKeyUseCase {
  KeysRepository repository;
  UserRepository userRepository;

  CreateKeyUseCase({required this.repository, required this.userRepository});

  Future<void> invoke({required String email , required MyKey key}) async {
    var response = await userRepository.getUserDataByEmail(email: email);
    key.userId =response.uid;
    await repository.createKey(key: key);
  }
}
