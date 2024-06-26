import 'package:heimdall/Data/DataSource/FirebaseLockUsersRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockUsersRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/UserLockRepository.dart';

UserLockRepository injectUserLockRepository(){
  return UserLockRepositoryImpl(remoteDataSource: injectFirebaseLockUsersRemoteDataSource());
}

class UserLockRepositoryImpl implements UserLockRepository {

  FirebaseLockUsersRemoteDataSource remoteDataSource;
  UserLockRepositoryImpl({required this.remoteDataSource});

  @override
  addLockUser({required String lockId, required MyUser user}) async{
    await remoteDataSource.addLockUser(lockId: lockId, userDTO: user.toDataSource());
  }

  @override
  Future<bool> userExist({required String lockId, required String uid}) async{
    var response = await remoteDataSource.userExist(lockId: lockId, uid: uid);
    return response;
  }

  @override
  Future<List<MyUser>> getAllUsers({required String lockId}) async{
    var response = await remoteDataSource.getAllUsers(lockId: lockId);
    return response;
  }

  @override
  Future<void> deleteUser({required String uid, required String lockId}) async{
    await remoteDataSource.deleteUser(uid: uid, lockId: lockId);
  }

}