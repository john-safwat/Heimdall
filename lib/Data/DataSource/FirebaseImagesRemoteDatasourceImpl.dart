import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:heimdall/Data/ErrorHandler/FirebaseArabicErrorHandler.dart';
import 'package:heimdall/Data/ErrorHandler/FirebaseEnglishErrorHandler.dart';
import 'package:heimdall/Data/Firebase/FirebaseImagesDatabase.dart';
import 'package:heimdall/Domain/DataSource/FirebaseImagesRemoteDatasource.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseImagesException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:image_picker/image_picker.dart';

// dependency injection
FirebaseImagesRemoteDatasource injectFirebaseImagesRemoteDatasource() {
  return FirebaseImagesRemoteDatasourceImpl(
      database: injectFirebaseImagesDatabase(),
      arabicErrorHandler: injectFirebaseArabicErrorHandler(),
      englishErrorHandler: injectFirebaseEnglishErrorHandler());
}

// the object
class FirebaseImagesRemoteDatasourceImpl
    implements FirebaseImagesRemoteDatasource {
  FirebaseImagesDatabase database;
  FirebaseEnglishErrorHandler englishErrorHandler;
  FirebaseArabicErrorHandler arabicErrorHandler;
  FirebaseImagesRemoteDatasourceImpl(
      {required this.database,
      required this.englishErrorHandler,
      required this.arabicErrorHandler});

  // function to upload user image to firebase fireStore
  @override
  Future<String> uploadImage(
      {required String local, required XFile file}) async {
    try {
      var response = await database
          .uploadImage(file: file)
          .timeout(const Duration(seconds: 60));
      return response;
    } on FirebaseException catch (e) {
      throw FirebaseImagesException(
          errorMessage: local == "en"
              ? englishErrorHandler.handleFirebaseAuthException(error: e.code)
              : arabicErrorHandler.handleFirebaseAuthException(error: e.code));
    } on TimeoutException catch (e) {
      throw TimeOutOperationsException(
          errorMessage: "Uploading Image Timed Out Try Again");
    } catch (e) {
      throw UnknownException(errorMessage: "UnKnown Error");
    }
  }

}
