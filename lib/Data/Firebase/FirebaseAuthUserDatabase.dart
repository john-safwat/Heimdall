import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Users/UserDTO.dart';
import 'package:shared_preferences/shared_preferences.dart';

// dependency injection
FirebaseAuthUserDatabase injectFirebaseAuthUserDatabase(){
  return FirebaseAuthUserDatabase.getInstance();
}

class FirebaseAuthUserDatabase extends BaseDatabase{

  // singleton pattern
  FirebaseAuthUserDatabase._();
  static FirebaseAuthUserDatabase? _instance ;

  static FirebaseAuthUserDatabase getInstance(){
    return _instance??=FirebaseAuthUserDatabase._();
  }

  final _firebase = FirebaseAuth.instance;

  // function to create user in firebase auth
  Future<User> createUser({required UserDTO user}) async {
    await _firebase.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password).then((value) => value.user!.updateDisplayName(user.name));
    return _firebase.currentUser!;
  }

  // function to update user photo in firebase auth
  Future<User> updateUserPhoto(String photo)async{
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(photo);
    return _firebase.currentUser!;
  }

  // function to update user name in firebase auth
  Future<User> updateUserDisplayName(String name)async{
    await _firebase.currentUser!.updateDisplayName(name);
    return _firebase.currentUser!;
  }

  // sign in user with email and password to firebase auth
  Future<User> signInUserWithEmailAndPassword({required String email , required String password}) async{
    await _firebase.signInWithEmailAndPassword(email: email, password: password);
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.setBool("loggedIn", true);
    return _firebase.currentUser!;
  }

  // function to send reset password email to the user when forget password
  Future<void> resetPassword({required String email})async{
    await _firebase.sendPasswordResetEmail(email: email);
  }

  // login the user using google account
  Future<User> signInWithGoogle()async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    final user = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _firebase.signInWithCredential(user);
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.setBool("loggedIn", true);
    return _firebase.currentUser!;
  }

  // function to delete account
  Future<void> deleteAccount()async{
    await _firebase.currentUser!.delete();
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.setBool("loggedIn", false);
  }

  // function to signUserOut
  Future<void> signOut()async{
    await _firebase.signOut();
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.setBool("loggedIn", false);
  }

  // function to change password
  Future<User> changePassword({required String password , required String newPassword , required String email})async{
    await _firebase.signInWithEmailAndPassword(email: email, password: password);
    await _firebase.currentUser!.updatePassword(newPassword);
    return _firebase.currentUser!;
  }

}