import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetTripwireParametersUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateRequestImageStateUseCase.dart';
import 'package:heimdall/Presentation/UI/TripwireSettings/TripwireSettingsNavigator.dart';

class TripwireSettingsViewModel
    extends BaseViewModel<TripwireSettingsNavigator> {
  GetTripwireParametersUseCase getTripwireImageAndStateUseCase;
  UpdateRequestImageStateUseCase updateRequestImageStateUseCase;
  LockCard lockCard;

  TripwireSettingsViewModel(
      {required this.lockCard,
      required this.getTripwireImageAndStateUseCase,
      required this.updateRequestImageStateUseCase});

  String? errorMessage;
  String imageUrl = "";
  bool state = false;
  bool loading = true;

  final formKey = GlobalKey<FormState>();
  TextEditingController x1PointController = TextEditingController();
  TextEditingController x2PointController = TextEditingController();
  TextEditingController y1PointController = TextEditingController();
  TextEditingController y2PointController = TextEditingController();

  double x1 = 0;
  double y1 = 0;
  double x2 = 0;
  double y2 = 0;

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
      x1PointController.text = response.$3.$1.toString();
      y1PointController.text = response.$3.$2.toString();
      x2PointController.text = response.$3.$3.toString();
      y2PointController.text = response.$3.$4.toString();
      x1 = response.$3.$1.toDouble() * (360 / 620);
      y1 = response.$3.$2.toDouble() * (360 / 620);
      x2 = response.$3.$3.toDouble() * (360 / 620);
      y2 = response.$3.$4.toDouble() * (360 / 620);
      notifyListeners();
    } catch (e) {
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }
  }

  updateLine() {
    x1 = double.parse(x1PointController.text) * (360 / 620);
    y1 = double.parse(y1PointController.text) * (360 / 620);
    x2 = double.parse(x2PointController.text) * (360 / 620);
    y2 = double.parse(y2PointController.text) * (360 / 620);
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

  String? validateNumberInputForXPoint(String? value) {
    if (value == null || value.isEmpty) {
      return local!.enterValidValue;
    }
    final number = int.tryParse(value);
    if (number == null) {
      return local!.enterValidNumber;
    }
    if (number < 0 || number > 640) {
      return local!.enterValidXPoint;
    }
    return null; // No error, validation successful
  }

  String? validateNumberInputForYPoint(String? value) {
    if (value == null || value.isEmpty) {
      return local!.enterValidValue;
    }
    final number = int.tryParse(value);
    if (number == null) {
      return local!.enterValidNumber;
    }
    if (number < 0 || number > 360) {
      return local!.enterValidYPoint;
    }
    return null; // No error, validation successful
  }

  void requestNewImage()async {
    try{
      await updateRequestImageStateUseCase.invoke(lockId: lockCard.lockId, state: !state);
      state = !state;
      notifyListeners();
    }catch(e){
      navigator!.showErrorNotification(message: handleErrorMessage(e as Exception));
    }
  }
}
