import 'package:heimdall/Data/DataSource/FirebaseLockUsersRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockUsersRemoteDataSource.dart';
import 'package:heimdall/Domain/Repository/UserLockRepository.dart';

UserLockRepository injectUserLockRepository(){
  return UserLockRepositoryImpl(remoteDataSource: injectFirebaseLockUsersRemoteDataSource());
}

class UserLockRepositoryImpl implements UserLockRepository {

  FirebaseLockUsersRemoteDataSource remoteDataSource;
  UserLockRepositoryImpl({required this.remoteDataSource});

}