import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository {

  Future<User> createUserFirebaseAuth({ required MyUser user});
  Future<void> createUserFirebaseDatabase({ required MyUser user });
  Future<String> uploadUserImageToDatabase({ required XFile image});
  Future<String> updateUserImageToDatabase({ required XFile image,required String url});
  Future<User> updateUserImageInUserCredential({ required String image});
  Future<User> updateUserDisplayName({required String name});
  Future<void> updateUser({ required MyUser user});
  Future<void> resetPassword({ required String email});
  Future<User> signInWithEmailAndPassword({ required String email ,required String password});
  Future<bool> checkIfUserExist({ required String uid});
  Future<User> signInWithGoogle();
  Future<MyUser> getUserDataByEmail({required String email});
  Future<void> deleteAccount({required String uid});
  Future<void> signOut();
  Future<MyUser> getUserData({required String uid});
  Future<User> changePassword({required String password , required String newPassword , required String email});

}