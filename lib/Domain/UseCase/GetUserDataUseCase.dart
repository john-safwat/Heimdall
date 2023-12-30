import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

GetUserDataUseCase injectGetUserDataUseCase(){
  return GetUserDataUseCase(repository: injectUserRepository());
}

class GetUserDataUseCase {

  UserRepository repository;
  GetUserDataUseCase({required this.repository});

  Future<MyUser> invoke({required String uid})async{
    var response = await repository.getUserData(uid: uid);
    return response;
  }


}