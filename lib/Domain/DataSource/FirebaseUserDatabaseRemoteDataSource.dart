import 'package:heimdall/Data/Models/Users/UserDTO.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';

abstract class FirebaseUserDatabaseRemoteDataSource {

  Future<void> createUserFirebaseDatabase({required UserDTO user });
  Future<void> updateUserProfile({required UserDTO user });
  Future<bool> checkIfUserExist({required String uid});
  Future<MyUser> getUserDataByEmail({required String email});
  Future<void> deleteAccount({required String uid});

}