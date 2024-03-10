import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewNavigator.dart';

class ImagePreviewViewModel extends BaseViewModel<ImagePreviewNavigator> {

  late String capturedImage;
  late String tag;
  late List<String> images;

  void onImageChange(String image){
     if(capturedImage == image){
       return;
     }
     capturedImage = images[images.indexOf(image)];
     notifyListeners();
  }

}