import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Core/ErrorHandler/FirebaseArabicErrorHandler.dart';
import 'package:heimdall/Core/ErrorHandler/FirebaseEnglishErrorHandler.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseImagesException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseLoginException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/PermissionDeniedException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UnknownException.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;

  ThemeProvider? themeProvider;
  LocalProvider? localProvider;
  AppConfigProvider? appConfigProvider;
  AppLocalizations? local;
  Size? mediaQuery;
  late FirebaseArabicErrorHandler firebaseArabicErrorHandler;
  late FirebaseEnglishErrorHandler firebaseEnglishErrorHandler;

  XFile? image;

  // image picker from camera
  Future<void> pickImageFromCamera() async {
    navigator!.goBack();
    final ImagePicker picker = ImagePicker();
    // Capture a photo.
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      this.image = image;
      notifyListeners();
    }
  }

  // image picker from gallery
  Future<void> pickImageFromGallery() async {
    navigator!.goBack();
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.image = image;
      notifyListeners();
    }
  }

  String handleErrorMessage(Exception e) {
    if (e is FirebaseDatabaseException) {
      return localProvider!.getLocal() == "en"
          ? firebaseEnglishErrorHandler.handleFirebaseFireStoreError(e.errorMessage)
          : firebaseArabicErrorHandler.handleFirebaseFireStoreError(e.errorMessage);
    } else if (e is FirebaseImagesException) {
      return localProvider!.getLocal() == "en"
          ? firebaseEnglishErrorHandler.handleFirebaseImageDatabaseExceptions(error: e.errorMessage,)
          : firebaseArabicErrorHandler.handleFirebaseImageDatabaseExceptions(error: e.errorMessage,);
    } else if (e is FirebaseUserAuthException) {
      return localProvider!.getLocal() == "en"
          ? firebaseEnglishErrorHandler.handleFirebaseAuthException(error: e.errorMessage,)
          : firebaseArabicErrorHandler.handleFirebaseAuthException(error: e.errorMessage,);
    } else if (e is FirebaseLoginException){
      return localProvider!.getLocal() == "en"
          ? firebaseEnglishErrorHandler.handleLoginError(e.errorMessage,)
          : firebaseArabicErrorHandler.handleLoginError(e.errorMessage,);
    }else if (e is InternetConnectionException) {
      return local!.checkYourInternetConnection ;
    } else if (e is PermissionDeniedException) {
      return local!.weDontHavePermissions;
    } else if (e is TimeOutOperationsException) {
      return local!.timeOutError;
    } else {
      return local!.unknownError;
    }
  }
}
