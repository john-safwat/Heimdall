import 'package:heimdall/Data/Repository/KeysRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Repository/KeysRepository.dart';

DeleteKeyUseCase injectDeleteKeyUseCase(){
  return DeleteKeyUseCase(repository: injectKeysRepository());
}

class DeleteKeyUseCase {

  KeysRepository repository;
  DeleteKeyUseCase({required this.repository});

  Future<void> invoke({required EKey key})async{
    await repository.deleteKey(key: key);
  }
}