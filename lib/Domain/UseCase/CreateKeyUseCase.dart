import 'package:heimdall/Data/Repository/KeysRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/UserLockRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Exceptions/UserIsOwnerException.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Repository/KeysRepository.dart';
import 'package:heimdall/Domain/Repository/UserLockRepository.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

CreateKeyUseCase injectCreateKeyUseCase() {
  return CreateKeyUseCase(
      repository: injectKeysRepository(),
      userRepository: injectUserRepository(),
      userLockRepository: injectUserLockRepository());
}

class CreateKeyUseCase {
  KeysRepository repository;
  UserRepository userRepository;
  UserLockRepository userLockRepository;

  CreateKeyUseCase(
      {required this.repository,
      required this.userRepository,
      required this.userLockRepository});

  Future<void> invoke({required String email, required EKey key}) async {
    var response = await userRepository.getUserDataByEmail(email: email);
    var exist = await userLockRepository.userExist(lockId: key.lockId!, uid: response.uid);
    if (exist) {
      throw UserIsOwnerException();
    }
    key.userId = response.uid;
    await repository.createKey(key: key);
  }
}
