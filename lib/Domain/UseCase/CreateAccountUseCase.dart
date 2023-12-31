import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

// dependency inject
CreateAccountUseCase injectCreateAccountUseCase(){
  return CreateAccountUseCase(userRepository: injectUserRepository());
}

class CreateAccountUseCase {

  UserRepository userRepository;
  CreateAccountUseCase ({required this.userRepository});

  Future<User> invoke({required MyUser user})async{
    var response = await userRepository.createUserFirebaseAuth(user: user);
    user.uid = response.uid;
    await response.sendEmailVerification();
    return response;
  }

}