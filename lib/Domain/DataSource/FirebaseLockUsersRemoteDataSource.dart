import 'package:heimdall/Data/Models/Users/UserDTO.dart';

abstract class FirebaseLockUsersRemoteDataSource {

  addLockUser({required String lockId , required UserDTO userDTO});
  Future<bool> userExist({required String lockId , required String uid});
}