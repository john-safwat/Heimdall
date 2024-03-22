import 'package:heimdall/Data/Repository/KeysRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Repository/KeysRepository.dart';

GetKeysUseCase injectGetKeysUseCase(){
  return GetKeysUseCase(repository: injectKeysRepository());
}

class GetKeysUseCase {
  KeysRepository repository;
  GetKeysUseCase({required this.repository});

  Future<List<EKey>> invoke({required String uid})async {
    var response = await repository.getUserKeys(uid: uid);
    return response;
  }

}