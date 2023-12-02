import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';


UpdateUserDataUseCase injectUpdateUserDataUseCase(){
  return UpdateUserDataUseCase(repository: injectUserRepository());
}

class UpdateUserDataUseCase {

  UserRepository repository ;
  UpdateUserDataUseCase ({required this.repository});

  Future<void> invoke({required MyUser user , required User currentUser})async{
    await repository.updateUser(user: user);
  }

}