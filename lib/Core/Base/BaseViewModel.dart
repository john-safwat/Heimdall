import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {

  N? navigator ;

  ThemeProvider? themeProvider;
  LocalProvider? localProvider;
  AppConfigProvider? appConfigProvider ;
  AppLocalizations? local ;
  Size? mediaQuery;


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



}