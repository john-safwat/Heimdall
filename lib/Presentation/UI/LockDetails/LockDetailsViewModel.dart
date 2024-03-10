import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetLockImagesListUseCase.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsNavigator.dart';

class LockDetailsViewModel extends BaseViewModel<LockDetailsNavigator> {

  LockCard lockCard ;
  GetLockImagesListUseCase getLockImagesListUseCase;
  LockDetailsViewModel({required this.lockCard , required this.getLockImagesListUseCase});

  List<String> images = [];
  String? imagesErrorMessage;
  bool imagesLoading = true;

  loadImagesList()async{
    images = [];
    imagesErrorMessage = null;
    imagesLoading = true;
    notifyListeners();
    try{
      images =await getLockImagesListUseCase.invoke(lockId: lockCard.lockId);
      imagesLoading = false;
      notifyListeners();
    }catch (e){
      imagesErrorMessage = handleErrorMessage(e as Exception);
      imagesLoading = false;
      notifyListeners();
    }
  }

  goToImagePreviewScreen(String image ,String tag){
    navigator!.goToImagePreviewScreen(image: image, tag: tag , images: images);
  }

  String getImageEmptyAnimation() {
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/CameraBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/lock3.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/CameraPurple.json";
    }else {
      return "assets/animations/CameraGold.json";
    }
  }

}