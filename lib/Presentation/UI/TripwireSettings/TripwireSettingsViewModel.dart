import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Providers/LocksProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetTripwireParametersUseCase.dart';
import 'package:heimdall/Domain/UseCase/SetLockRealTimeDatabaseListenerUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateRequestImageStateUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateTripwireParametersUseCase.dart';
import 'package:heimdall/Presentation/UI/TripwireSettings/TripwireSettingsNavigator.dart';

class TripwireSettingsViewModel
    extends BaseViewModel<TripwireSettingsNavigator> {
  GetTripwireParametersUseCase getTripwireImageAndStateUseCase;
  UpdateRequestImageStateUseCase updateRequestImageStateUseCase;
  UpdateTripwireParametersUseCase updateTripwireParametersUseCase;
  SetLockRealTimeDatabaseListenerUseCase setLockRealTimeDatabaseListenerUseCase;
  LockCard lockCard;
  late LocksProvider locksProvider;
  TripwireSettingsViewModel({required this.lockCard,
    required this.getTripwireImageAndStateUseCase,
    required this.updateRequestImageStateUseCase,
    required this.updateTripwireParametersUseCase,
    required this.setLockRealTimeDatabaseListenerUseCase
  });

  String? errorMessage;
  String? lockErrorMessage;
  String imageUrl = "";
  bool state = false;
  bool loading = true;
  bool lockLoading= true;


  double x1 = 0;
  double y1 = 0;
  double x2 = 0;
  double y2 = 0;


  double x1Real = 0;
  double y1Real = 0;
  double x2Real = 0;
  double y2Real = 0;

  double timer = 0;
  int realTimer = 0;

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

  loadParameters() async {
    loading = true;
    imageUrl = '';
    state = false;
    errorMessage = null;
    notifyListeners();
    try {
      var response =
      await getTripwireImageAndStateUseCase.invoke(lockId: lockCard.lockId);
      imageUrl = response.$1;
      state = response.$2;
      loading = false;
      x1Real = response.$3.$1.toDouble();
      y1Real = response.$3.$2.toDouble();
      x2Real = response.$3.$3.toDouble();
      y2Real = response.$3.$4.toDouble();
      realTimer = response.$4;
      notifyListeners();
      x1 = x1Real;
      y1 = y1Real;
      x2 = x2Real;
      y2 = y2Real;
      timer = realTimer.toDouble() / 200;
    } catch (e) {
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }
  }

  updateX1(int value) {
    x1Real = value.toDouble();
    x1 = value.toDouble() * (360 / 620);
    notifyListeners();
  }

  updateY1(int value) {
    y1Real = value.toDouble();
    y1 = value.toDouble() * (360 / 620);
    notifyListeners();
  }

  updateX2(int value) {
    x2Real = value.toDouble();
    x2 = value.toDouble() * (360 / 620);
    notifyListeners();
  }

  updateY2(int value) {
    y2Real = value.toDouble();
    y2 = value.toDouble() * (360 / 620);
    notifyListeners();
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

  void requestNewImage() async {
    try {
      await updateRequestImageStateUseCase.invoke(
          lockId: lockCard.lockId, state: !state);
      state = !state;
      notifyListeners();
    } catch (e) {
      navigator!.showErrorNotification(
          message: handleErrorMessage(e as Exception));
    }
  }

  void updateParameters() async {
    navigator!.showLoading(message: local!.loading);
    try {
      await updateTripwireParametersUseCase.invoke(lockId: lockCard.lockId,
          x1: x1Real.toInt(),
          x2: x2Real.toInt(),
          y1: y1Real.toInt(),
          y2: y2Real.toInt(),
          timer: realTimer);

      navigator!.goBack();
      navigator!.showSuccessMessage(message: local!.tripwireUpdated , posActionTitle: local!.ok);
    }catch(e){
      navigator!.goBack();
      navigator!.showFailMessage(message: handleErrorMessage(e  as Exception) , posActionTitle: local!.tryAgain);
    }
  }

  void updateTimer(double val) {
    realTimer = (val * 200).toInt();
    timer = val;
    notifyListeners();
  }
}
