import 'package:heimdall/Data/Models/Users/UserDTO.dart';

abstract class FirebaseUserDatabaseRemoteDataSource {

  Future<void> createUserFirebaseDatabase({required String local , required UserDTO user });
  Future<void> updateUserProfile({required String local , required UserDTO user });

}