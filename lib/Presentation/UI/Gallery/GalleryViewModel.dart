import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/Gallery/GalleryNavigator.dart';

class GalleryViewModel extends BaseViewModel<GalleryNavigator> {

  late List<String> images;

  goToImagePreviewScreen(String image, String tag) {
    navigator!.goToImagePreviewScreen(image: image, tag: tag, images: images);
  }
}