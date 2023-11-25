import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository {

  Future<User> createUserFirebaseAuth({required String local , required MyUser user});
  Future<void> createUserFirebaseDatabase({required String local , required MyUser user });
  Future<String> uploadUserImageToDatabase({required String local , required XFile image});
  Future<User> updateUserImageInUserCredential({required String local , required String image});
  Future<void> updateUser({required String local , required MyUser user});

}