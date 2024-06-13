import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/Gallery/GalleryNavigator.dart';

import '../../../Core/Theme/MyTheme.dart';

class GalleryViewModel extends BaseViewModel<GalleryNavigator> {

  late List<String> images;

  goToImagePreviewScreen(String image, String tag) {
    navigator!.goToImagePreviewScreen(image: image, tag: tag, images: images);
  }
  // function to get the animation
  String getAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/emptyBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/emptyPurple.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/emptyDarkPurple.json";
    }else {
      return "assets/animations/emptyBlue.json";
    }
  }


}