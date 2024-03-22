
import 'dart:io';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewNavigator.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:path_provider/path_provider.dart';

class ImagePreviewViewModel extends BaseViewModel<ImagePreviewNavigator> {

  late String capturedImage;
  late String tag;
  late List<String> images;

  late IndexedScrollController controller;

  void onImageChange(String image){
     if(capturedImage == image){
       return;
     }
     controller.jumpToIndex(images.indexOf(image));
     capturedImage = images[images.indexOf(image)];
     notifyListeners();
  }

  void showQuestionMessage(){
    navigator!.showQuestionMessage(
      message: local!.doYouWantToSave,
      negativeActionTitle: local!.cancel,
      posActionTitle: local!.ok,
      posAction: saveNetworkImage
    );
  }

  void saveNetworkImage() async {
    navigator!.showLoading(message: local!.loading);
    try {
      // Download image
      final http.Response response = await http.get(Uri.parse(capturedImage));
      // Get temporary directory
      final Directory? downloadsDir = await getDownloadsDirectory();
      // Create an image name
      var filename = '${downloadsDir!.path}/Heimdall-Saved-Image-${DateTime.now()}.jpg';
      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      await FlutterFileDialog.saveFile(params: params);

      navigator!.goBack();
      navigator!.showSuccessNotification(message: local!.imageSavedSuccessfully);
    } catch (e) {
      navigator!.goBack();
      navigator!.showErrorNotification(message: handleErrorMessage(e as Exception));
    }
  }

}