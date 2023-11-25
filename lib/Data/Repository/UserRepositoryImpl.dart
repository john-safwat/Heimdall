import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/DataSource/FirebaseAuthRemoteDataSourceImpl.dart';
import 'package:heimdall/Data/DataSource/FirebaseImagesRemoteDatasourceImpl.dart';
import 'package:heimdall/Data/DataSource/FirebaseUserDatabaseRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseAuthRemoteDataSource.dart';
import 'package:heimdall/Domain/DataSource/FirebaseImagesRemoteDatasource.dart';
import 'package:heimdall/Domain/DataSource/FirebaseUserDatabaseRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';
import 'package:image_picker/image_picker.dart';

UserRepository injectUserRepository() {
  return UserRepositoryImpl(
    authRemoteDataSource: injectFirebaseAuthRemoteDataSource(),
    userDatabaseRemoteDataSource: injectFirebaseUserDatabaseRemoteDataSource(),
      imagesRemoteDatasource: injectFirebaseImagesRemoteDatasource()
  );
}

class UserRepositoryImpl implements UserRepository {
  FirebaseAuthRemoteDataSource authRemoteDataSource;
  FirebaseImagesRemoteDatasource imagesRemoteDatasource;
  FirebaseUserDatabaseRemoteDataSource userDatabaseRemoteDataSource;
  UserRepositoryImpl(
      {required this.authRemoteDataSource,
      required this.userDatabaseRemoteDataSource,
        required this.imagesRemoteDatasource
      });

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

  // function to upload user image to firebase storage
  @override
  Future<User> updateUserImageInUserCredential({required String local, required String image}) async{
    var response = await authRemoteDataSource.updateUserImage(local: local, image: image);
    return response;
  }

  // upload user image to data base
  @override
  Future<String> uploadUserImageToDatabase({required String local, required XFile image}) async{
    var response = await imagesRemoteDatasource.uploadImage(local: local, file: image);
    return response;
  }

  // function to update user in database firebase fire Store
  @override
  Future<void> updateUser({required String local, required MyUser user}) async{
    await userDatabaseRemoteDataSource.updateUserProfile(local: local, user: user.toDataSource());
  }
}
