import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Data/Models/Users/UserDTO.dart';

abstract class FirebaseAuthRemoteDataSource {

  Future<User> createUser ({required String local , required UserDTO user});

}