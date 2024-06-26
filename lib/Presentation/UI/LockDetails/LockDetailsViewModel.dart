import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Providers/LocksProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Models/Log/Log.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/UseCase/ChangeLockStateUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetLockImagesListUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetLockKeysUseCase.dart';
import 'package:heimdall/Domain/UseCase/SetLockRealTimeDatabaseListenerUseCase.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsNavigator.dart';

class LockDetailsViewModel extends BaseViewModel<LockDetailsNavigator> {
  LockCard lockCard;

  GetLockImagesListUseCase getLockImagesListUseCase;
  SetLockRealTimeDatabaseListenerUseCase setLockRealTimeDatabaseListenerUseCase;
  ChangeLockStateUseCase changeLockStateUseCase;
  GetLockKeysUseCase getLockKeysUseCase;

  late LocksProvider locksProvider;

  LockDetailsViewModel(
      {required this.lockCard,
      required this.getLockImagesListUseCase,
      required this.setLockRealTimeDatabaseListenerUseCase,
      required this.changeLockStateUseCase,
      required this.getLockKeysUseCase});

  List<String> images = [];
  List<EKey> keys = [];
  String? imagesErrorMessage;
  String? lockErrorMessage;
  String? keysErrorMessage;
  bool imagesLoading = true;
  bool lockLoading = true;
  bool keysLoading = true;

  loadData(){
    loadImagesList();
    setDatabaseListener();
    loadKeys();
  }

  loadImagesList() async {
    images = [];
    imagesErrorMessage = null;
    imagesLoading = true;
    notifyListeners();
    try {
      images = await getLockImagesListUseCase.invoke(lockId: lockCard.lockId);
      imagesLoading = false;
      notifyListeners();
    } catch (e) {
      imagesErrorMessage = handleErrorMessage(e as Exception);
      imagesLoading = false;
      notifyListeners();
    }
  }

  loadKeys()async{
    keys = [];
    keysErrorMessage = null;
    keysLoading = true;
    try {
      keys = await getLockKeysUseCase.invoke(lockId: lockCard.lockId);
      keysLoading = false;
      notifyListeners();
    } catch (e) {
      keysErrorMessage = handleErrorMessage(e as Exception);
      keysLoading = false;
      notifyListeners();
    }
  }

  setDatabaseListener() async {
    lockErrorMessage = null;
    lockLoading = true;
    notifyListeners();
    try {
      await setLockRealTimeDatabaseListenerUseCase.invoke(
          lockId: lockCard.lockId);
      lockLoading = false;
      notifyListeners();
    } catch (e) {
      lockErrorMessage = handleErrorMessage(e as Exception);
      lockLoading = false;
      notifyListeners();
    }
  }

  goToImagePreviewScreen(String image, String tag) {
    navigator!.goToImagePreviewScreen(image: image, tag: tag, images: images);
  }

  changeLockState() async {
    if (authenticated) {
      try {
        var data = locksProvider.value;
        await changeLockStateUseCase.invoke(
            lockState: !data["opened"],
            log: Log(
                eventType: !data["opened"] ? "UnLock" : "Closed",
                id: lockCard.lockId,
                method: "Mobile",
                timeOpened: DateTime.now().toUtc(),
                uid: appConfigProvider!.user!.uid,
                userName: appConfigProvider!.user!.displayName ?? "UnKnown"),
            notification: MyNotification(
                id: lockCard.lockId,
                code: !data["opened"] ? 101 : 102,
                body: !data["opened"]
                    ? "This Lock Is Opened Using Mobile App Successfully"
                    : "This Lock Is Closed Using Mobile App Successfully",
                priority: "low",
                time: DateTime.now().toUtc(),
                urls: []));
        notifyListeners();
      } catch (e) {
        notifyListeners();
      }
    } else {
      await authenticateUser();
      if (authenticated) {
        changeLockState();
      }
    }
  }

  String getImageEmptyAnimation() {
    if (themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme) {
      return "assets/animations/CameraBlack.json";
    } else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme) {
      return "assets/animations/lock3.json";
    } else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme) {
      return "assets/animations/CameraPurple.json";
    } else {
      return "assets/animations/CameraGold.json";
    }
  }
// function to return the icon of the app
  String getIcon() {
    if (themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme) {
      return "assets/images/appIcon2.png";
    } else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme) {
      return "assets/images/appIcon3.png";
    } else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme) {
      return "assets/images/appIcon4.png";
    } else {
      return "assets/images/appIcon5.png";
    }
  }
  goToGalleryScreen() {
    navigator!.goToGalleryScreen(images: images);
  }

  goToCreateKeyScreen() {
    navigator!.goToCreateKeyScreen(lockCard: lockCard);
  }

  onCardClick(EKey key){
    navigator!.goToManageKeyScreen(lockCard: lockCard, eKey: key);
  }

}
