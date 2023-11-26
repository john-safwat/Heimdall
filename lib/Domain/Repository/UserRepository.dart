import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository {

  Future<User> createUserFirebaseAuth({required String local , required MyUser user});
  Future<void> createUserFirebaseDatabase({required String local , required MyUser user });
  Future<String> uploadUserImageToDatabase({required String local , required XFile image});
  Future<User> updateUserImageInUserCredential({required String local , required String image});
  Future<void> updateUser({required String local , required MyUser user});
  Future<void> resetPassword({required String local , required String email});
  Future<User> signInWithEmailAndPassword({required String local ,required String email ,required String password});
  Future<bool> checkIfUserExist({required String local , required String uid});
  Future<User> signInWithGoogle({required String local});

}