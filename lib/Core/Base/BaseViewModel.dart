import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Core/Constants/Constants.dart';
import 'package:heimdall/Core/Errors/FirebaseAuthExceptionHandler.dart';
import 'package:heimdall/Core/Errors/FirebaseFireStoreErrorHandler.dart';
import 'package:heimdall/Core/Errors/FirebaseImageDatabaseExceptionsHandler.dart';
import 'package:heimdall/Core/Errors/FirebaseLoginErrorHandler.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heimdall/Domain/Exceptions/ContactExistException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseDatabaseException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseImagesException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseLoginException.dart';
import 'package:heimdall/Domain/Exceptions/FirebaseUserAuthException.dart';
import 'package:heimdall/Domain/Exceptions/InternetConnectionException.dart';
import 'package:heimdall/Domain/Exceptions/PermissionDeniedException.dart';
import 'package:heimdall/Domain/Exceptions/RecursiveChatUnAvailableException.dart';
import 'package:heimdall/Domain/Exceptions/TimeOutOperationsException.dart';
import 'package:heimdall/Domain/Exceptions/UserNotExistException.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;

  ThemeProvider? themeProvider;
  LocalProvider? localProvider;
  AppConfigProvider? appConfigProvider;
  AppLocalizations? local;
  Size? mediaQuery;
  Constants constants = Constants.getInstance();
  late FirebaseAuthExceptionHandler firebaseAuthExceptionHandler;
  late FirebaseFireStoreErrorHandler firebaseFireStoreErrorHandler;
  late FirebaseImageDatabaseExceptionsHandler
      firebaseImageDatabaseExceptionsHandler;
  late FirebaseLoginErrorHandler firebaseLoginErrorHandler;

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
          ? firebaseFireStoreErrorHandler
          .handleFirebaseFireStoreErrorEnglish(e.errorMessage)
          : firebaseFireStoreErrorHandler
          .handleFirebaseFireStoreErrorArabic(e.errorMessage);
    } else if (e is FirebaseImagesException) {
      return localProvider!.getLocal() == "en"
          ? firebaseImageDatabaseExceptionsHandler
          .handleFirebaseImageDatabaseExceptionsEnglish(error: e.errorMessage)
          : firebaseImageDatabaseExceptionsHandler
          .handleFirebaseImageDatabaseExceptionsArabic(error: e.errorMessage);
    } else if (e is FirebaseUserAuthException) {
      return localProvider!.getLocal() == "en"
          ? firebaseAuthExceptionHandler.handleFirebaseAuthExceptionEnglish(
          error: e.errorMessage)
          : firebaseAuthExceptionHandler.handleFirebaseAuthExceptionArabic(
          error: e.errorMessage);
    } else if (e is FirebaseLoginException) {
      return localProvider!.getLocal() == "en"
          ? firebaseLoginErrorHandler
          .handleLoginErrorEnglish(e.errorMessage)
          : firebaseLoginErrorHandler
          .handleLoginErrorArabic(e.errorMessage);
    } else if (e is InternetConnectionException) {
      return local!.checkYourInternetConnection;
    } else if (e is PermissionDeniedException) {
      return local!.weDontHavePermissions;
    } else if (e is TimeOutOperationsException) {
      return local!.timeOutError;
    } else if (e is UserNotExistException) {
      return local!.userNotExist;
    } else if (e is ContactExistException) {
      return local!.contactAlreadyExist;
    } else if (e is RecursiveChatUnAvailableException){
      return local!.recursiveChatUnAvailable;
    }else {
      return local!.unknownError;
    }
  }
}
