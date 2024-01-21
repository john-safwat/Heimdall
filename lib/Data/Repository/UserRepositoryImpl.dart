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
  Future<User> createUserFirebaseAuth({ required MyUser user}) async {
    var response = await authRemoteDataSource.createUser(user: user.toDataSource());
    return response;
  }

  // create user in the firebase database
  @override
  Future<void> createUserFirebaseDatabase(
      { required MyUser user}) async {
    await userDatabaseRemoteDataSource.createUserFirebaseDatabase(user: user.toDataSource());
  }

  // function to upload user image to firebase storage
  @override
  Future<User> updateUserImageInUserCredential({required String image}) async{
    var response = await authRemoteDataSource.updateUserImage( image: image);
    return response;
  }

  // upload user image to data base
  @override
  Future<String> uploadUserImageToDatabase({required XFile image}) async{
    var response = await imagesRemoteDatasource.uploadImage(file: image);
    return response;
  }

  // function to update user in database firebase fire Store
  @override
  Future<void> updateUser({required MyUser user}) async{
    await userDatabaseRemoteDataSource.updateUserProfile( user: user.toDataSource());
  }

  @override
  Future<void> resetPassword({ required String email}) async{
    await authRemoteDataSource.resetPassword(email: email);
  }

  @override
  Future<User> signInWithEmailAndPassword({ required String email, required String password}) async{
    var response = await authRemoteDataSource.signInWithEmailAndPassword(email: email, password: password);
    return response;
  }

  @override
  Future<bool> checkIfUserExist({ required String uid}) async{
    var response = await userDatabaseRemoteDataSource.checkIfUserExist(uid: uid);
    return response;
  }

  @override
  Future<User> signInWithGoogle() async{
    var response = await authRemoteDataSource.signInWithGoogle();
    return response;
  }

  @override
  Future<MyUser> getUserDataByEmail({required String email})async {
    var response = await userDatabaseRemoteDataSource.getUserDataByEmail(email: email);
    return response;
  }

  @override
  Future<void> deleteAccount({required String uid}) async{
    await authRemoteDataSource.deleteAccount();
    await userDatabaseRemoteDataSource.deleteAccount(uid: uid);
  }

  @override
  Future<void> signOut() async{
    await authRemoteDataSource.signOut();
  }

  @override
  Future<MyUser> getUserData({required String uid}) async{
    var response = await userDatabaseRemoteDataSource.getUserData(uid: uid);
    return response;
  }

  @override
  Future<User> updateUserDisplayName({required String name}) async{
    var response = await authRemoteDataSource.updateUserDisplayName(name: name);
    return response;
  }

  @override
  Future<String> updateUserImageToDatabase({required XFile image, required String url}) async{
    var response = await imagesRemoteDatasource.updateImage(file: image, url: url);
    return response;
  }

}
