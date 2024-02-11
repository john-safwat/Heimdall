import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:randomstring_dart/randomstring_dart.dart';

// dependency injection
FirebaseImagesDatabase injectFirebaseImagesDatabase(){
  return FirebaseImagesDatabase.getInstance();
}

// the object
class FirebaseImagesDatabase extends BaseDatabase{

  FirebaseImagesDatabase._();
  static FirebaseImagesDatabase? instance;
  static getInstance(){
    return instance ??= FirebaseImagesDatabase._();
  }

  final _firebaseStorage = FirebaseStorage.instance;

  // upload image to firebase storage
  Future<String> uploadImage({required XFile file})async{

    // upload image to firebase storage
    var snapshot = await _firebaseStorage.ref().child('images/${generateName()}').putFile(File(file.path),  SettableMetadata(contentType: "image/jpeg"));
    // get the image URL from firebase storage
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  // upload image to firebase storage
  Future<String> updateImage({required String url , required XFile file})async{
    // upload image to firebase storage
    var snapshot = await _firebaseStorage.refFromURL(url).putFile(File(file.path),  SettableMetadata(contentType: "image/jpeg"));
    // get the image URL from firebase storage
    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // generate random string for image name
  String generateName(){
    return RandomString().getRandomString(
        lowersCount: 20 ,
        numbersCount: 20,
        specialsCount: 4,
        uppersCount: 20,
        canSpecialRepeat: true,
        specials: "_"
    );
  }
}