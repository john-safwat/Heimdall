import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/DataSource/FirebaseAuthRemoteDataSourceImpl.dart';
import 'package:heimdall/Data/DataSource/FirebaseUserDatabaseRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseAuthRemoteDataSource.dart';
import 'package:heimdall/Domain/DataSource/FirebaseUserDatabaseRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

UserRepository injectUserRepository() {
  return UserRepositoryImpl(
      authRemoteDataSource: injectFirebaseAuthRemoteDataSource(),
      userDatabaseRemoteDataSource:
          injectFirebaseUserDatabaseRemoteDataSource());
}

class UserRepositoryImpl implements UserRepository {
  FirebaseAuthRemoteDataSource authRemoteDataSource;
  FirebaseUserDatabaseRemoteDataSource userDatabaseRemoteDataSource;
  UserRepositoryImpl(
      {required this.authRemoteDataSource,
      required this.userDatabaseRemoteDataSource});

  // create user in the firebase auth
  @override
  Future<User> createUserFirebaseAuth(
      {required String local, required MyUser user}) async {
    var response = await authRemoteDataSource.createUser(
        local: local, user: user.toDataSource());
    return response;
  }

  // create user in the firebase database
  @override
  Future<void> createUserFirebaseDatabase(
      {required String local, required MyUser user}) async {
    await userDatabaseRemoteDataSource.createUserFirebaseDatabase(
        local: local, user: user.toDataSource());
  }
}
