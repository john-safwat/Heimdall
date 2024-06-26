import 'package:heimdall/Domain/Models/Users/User.dart';

abstract class UserLockRepository {

  addLockUser({required String lockId , required MyUser user});
  Future<bool> userExist({required String lockId , required String uid});
  Future<List<MyUser>> getAllUsers({required String lockId});
  Future<void> deleteUser({required String uid , required String lockId});
}