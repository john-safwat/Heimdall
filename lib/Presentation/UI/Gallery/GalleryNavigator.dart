import 'package:heimdall/Core/Base/BaseNavigator.dart';

abstract class GalleryNavigator extends BaseNavigator {
  goToImagePreviewScreen({required String image , required String tag , required List<String> images});

}