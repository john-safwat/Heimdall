
import 'package:heimdall/Data/Models/Users/UserDTO.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';

abstract class FirebaseLockUsersRemoteDataSource {

  addLockUser({required String lockId , required UserDTO userDTO});
  Future<bool> userExist({required String lockId , required String uid});
  Future<List<MyUser>> getAllUsers({required String lockId});
  Future<void> deleteUser({required String uid , required String lockId});
}