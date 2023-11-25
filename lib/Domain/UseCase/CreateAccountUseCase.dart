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

  Future<User> invoke({required String local , required MyUser user})async{
    var response = await userRepository.createUserFirebaseAuth(local: local, user: user);
    user.uid = response.uid;
    await response.sendEmailVerification();
    await userRepository.createUserFirebaseDatabase(local: local, user: user);
    return response;
  }

}