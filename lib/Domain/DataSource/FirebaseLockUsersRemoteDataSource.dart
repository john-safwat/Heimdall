import 'package:heimdall/Data/Models/Users/UserDTO.dart';

abstract class FirebaseLockUsersRemoteDataSource {

  addLockUser({required String lockId , required UserDTO userDTO});

}