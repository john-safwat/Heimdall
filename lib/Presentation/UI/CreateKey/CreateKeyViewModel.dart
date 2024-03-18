import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/UseCase/CreateKeyUseCase.dart';
import 'package:heimdall/Presentation/UI/CreateKey/CreateKeyNavigator.dart';
import 'package:time_range_picker/time_range_picker.dart';

class CreateKeyViewModel extends BaseViewModel<CreateKeyNavigator> {
  CreateKeyUseCase createKeyUseCase;

  CreateKeyViewModel({required this.createKeyUseCase, required this.lockCard});

  TextEditingController emailController = TextEditingController();

  LockCard lockCard;

  bool validOnce = true;

  DateTime singleDate = DateTime.now();
  DateTimeRange rangeDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  TimeRange rangeTime =
      TimeRange(startTime: TimeOfDay.now(), endTime: TimeOfDay.now());

  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<String> selectedDays = [];

  onTypeButtonPress(int id) {
    if (id == 1 && validOnce) {
      return;
    }
    if (id == 2 && !validOnce) {
      return;
    }
    id == 1 ? validOnce = true : validOnce = false;
    notifyListeners();
  }

  onDayClick(String day) {
    selectedDays.contains(day)
        ? selectedDays.remove(day)
        : selectedDays.add(day);
    notifyListeners();
  }

  showDatePicker() async {
    singleDate = await navigator!.showDatePiker(singleDate);
    notifyListeners();
  }

  showRangeDatePicker() async {
    rangeDate = await navigator!.showRangeDatePiker(rangeDate);
    notifyListeners();
  }

  showRangeTimePicker() async {
    rangeTime = await navigator!.showRangeTimePiker(rangeTime);
    notifyListeners();
  }

  // validate on the email form
  String? emailValidation(String input) {
    if (input.isEmpty) {
      return local!.emailCantBeEmpty;
    } else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
            r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(input)) {
      return local!.enterAValidEmail;
    }
    return null;
  }

  createKey() async {
    if (emailController.text.isEmpty) {
      navigator!.showErrorNotification(message: local!.emailCantBeEmpty);
    } else if (emailController.text == appConfigProvider!.user!.email) {
      navigator!.showFailMessage(
          message: local!.youAreTheOwner, posActionTitle: local!.ok);
    } else {
      navigator!.showLoading(message: local!.loading);
      try {
        await createKeyUseCase.invoke(
            email: emailController.text,
            key: MyKey(
                keyId: "",
                lockId: lockCard.lockId,
                userId: "",
                ownerId: appConfigProvider!.user!.uid,
                ownerName: appConfigProvider!.user!.displayName ?? "No Name",
                ownerImage: appConfigProvider!.user!.photoURL ?? "",
                validOnce: validOnce,
                startDate: validOnce ? singleDate : rangeDate.start,
                endDate: validOnce ? singleDate : rangeDate.end,
                startTime: rangeTime.startTime,
                endTime: rangeTime.endTime,
                lockName: lockCard.name,
                days: selectedDays));
        navigator!.goBack();
        navigator!.showSuccessMessage(message: local!.keyCreated , posActionTitle: local!.ok);
      } catch (e) {
        navigator!.goBack();
        navigator!.showFailMessage(message: handleErrorMessage(e as Exception), posActionTitle: local!.ok);
      }
    }
  }
}
