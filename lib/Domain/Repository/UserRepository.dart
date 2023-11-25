import 'package:firebase_auth/firebase_auth.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';

abstract class UserRepository {

  Future<User> createUserFirebaseAuth({required String local , required MyUser user});
  Future<void> createUserFirebaseDatabase({required String local , required MyUser user });

}