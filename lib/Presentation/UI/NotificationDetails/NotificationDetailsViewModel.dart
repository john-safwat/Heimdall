import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/UseCase/GetCardUseCase.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/NotificationDetailsNavigator.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class NotificationDetailsViewModel
    extends BaseViewModel<NotificationDetailsNavigator> {
  MyNotification notification;
  GetCardUseCase getCardUseCase;

  NotificationDetailsViewModel(
      {required this.notification, required this.getCardUseCase});

  late LockCard card;

  bool loading = true;
  String? errorMessage;

  loadData() async {
    loading = true;
    errorMessage = null;
    notifyListeners();
    try {
      card = await getCardUseCase.invoke(
          uid: appConfigProvider!.user!.uid, lockId: notification.id);
      loading = false;
      notifyListeners();
    }catch(e){
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }
  }


  onLockCardPress(LockCard card){
    navigator!.goToLockDetailsScreen(card);
  }

  makeEmergencyCall(){
    Uri url = Uri.parse("tel://122");
    launchUrl(url);
  }

  goToImagePreviewScreen(String image, String tag) {
    navigator!.goToImagePreviewScreen(image: image, tag: tag, images: notification.urls);
  }

}