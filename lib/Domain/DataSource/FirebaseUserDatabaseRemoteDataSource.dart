import 'package:heimdall/Data/Models/Users/UserDTO.dart';

abstract class FirebaseUserDatabaseRemoteDataSource {

  Future<void> createUserFirebaseDatabase({required UserDTO user });
  Future<void> updateUserProfile({required UserDTO user });
  Future<bool> checkIfUserExist({required String uid});

}