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

}