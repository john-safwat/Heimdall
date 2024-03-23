import 'package:heimdall/Data/Repository/KeysRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Repository/KeysRepository.dart';

UpdateKeyUseCase injectUpdateKeyUseCase(){
  return UpdateKeyUseCase(repository: injectKeysRepository());
}

class UpdateKeyUseCase {

  KeysRepository repository;
  UpdateKeyUseCase({required this.repository});

  Future<void> invoke({required EKey key})async{
    await repository.updateKey(key: key);
  }
}