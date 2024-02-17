import 'package:heimdall/Data/Firebase/FirebaseLockUserDatabase.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockUsersRemoteDataSource.dart';

FirebaseLockUsersRemoteDataSource injectFirebaseLockUsersRemoteDataSource(){
  return FirebaseLockUsersRemoteDataSourceImpl(database: injectFirebaseLockUsersDatabase());
}

class FirebaseLockUsersRemoteDataSourceImpl implements FirebaseLockUsersRemoteDataSource {

  FirebaseLockUsersDatabase database;
  FirebaseLockUsersRemoteDataSourceImpl({required this.database});

}