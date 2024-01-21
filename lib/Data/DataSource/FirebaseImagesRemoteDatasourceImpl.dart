import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:heimdall/Data/Firebase/FirebaseImagesDatabase.dart';
import 'package:heimdall/Domain/DataSource/FirebaseImagesRemoteDatasource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseImagesException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:image_picker/image_picker.dart';

// dependency injection
FirebaseImagesRemoteDatasource injectFirebaseImagesRemoteDatasource() {
  return FirebaseImagesRemoteDatasourceImpl(
      database: injectFirebaseImagesDatabase());
}

// the object
class FirebaseImagesRemoteDatasourceImpl
    implements FirebaseImagesRemoteDatasource {
  FirebaseImagesDatabase database;
  FirebaseImagesRemoteDatasourceImpl(
      {required this.database});

  // function to upload user image to firebase fireStore
  @override
  Future<String> uploadImage({ required XFile file}) async {
    try {
      var response = await database.uploadImage(file: file).timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      throw FirebaseImagesException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    }on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "Uploading Image Timed Out Try Again");
    } catch (e) {
      throw UnknownException(errorMessage: "UnKnown Error");
    }
  }

  @override
  Future<String> updateImage({required XFile file,required String url}) async{
    try {
      var response = await database.updateImage(file: file, url: url).timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      throw FirebaseImagesException(errorMessage: e.code);
    } on IOException {
      throw InternetConnectionException(errorMessage: "I/O Exception");
    }on TimeoutException catch (e) {
      throw TimeOutOperationsException(errorMessage: "Uploading Image Timed Out Try Again");
    } catch (e) {
      throw UnknownException(errorMessage: "UnKnown Error");
    }
  }

}
