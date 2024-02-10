import 'package:flutter/cupertino.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/AddLockCardUseCase.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockNavigator.dart';
import 'package:heimdall/Presentation/UI/Widgets/AvatarImagesListWidget.dart';

class ConfigureLockViewModel extends BaseViewModel<ConfigureLockNavigator> {
  AddLockCardUseCase addLockCardUseCase;

  ConfigureLockViewModel({required this.addLockCardUseCase});

  String lockId = '';
  late String lockAvatar = avatars.first;
  List<String> avatars = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14"
  ];
  late TextEditingController nameController =
  TextEditingController(text: local!.setLockName);
  late Color cardColor = themeProvider!.getSecondaryColor();

  void readLockId(String? lockId) {
    this.lockId = lockId ?? "";
    notifyListeners();
  }

  // validate on the name if it is not empty and doesn't contain ant spacial characters
  String? nameValidation(String name) {
    if (name.isEmpty) {
      return local!.nameCantBeEmpty;
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(name)) {
      return local!.invalidName;
    } else {
      return null;
    }
  }

  showSelectImageBottomSheet() {
    navigator!.showCustomModalBottomSheet(
        widget: AvatarImagesListWidget(
          selectedItem: lockAvatar,
          onSelectedItemPress: changeSelectedImage,
          images: avatars,
        ));
  }

  changeSelectedImage(String newAvatar) {
    lockAvatar = newAvatar;
    notifyListeners();
  }

  onColorPickerClick() {
    navigator!.showColorPickerDialog();
  }

  changeColor(Color color) {
    cardColor = color;
    notifyListeners();
  }

  Future<void> saveCard() async {
    if (nameController.text.isNotEmpty) {
      try {
        navigator!.showLoading(message: local!.loading);
        await addLockCardUseCase.invoke(
            uid: appConfigProvider!.user!.uid,
            lockCard: LockCard(
              image: "assets/avatars/avatar$lockAvatar.png",
              name: nameController.text,
              color: cardColor.value,
              lockId: lockId,
              cardId: "",
            ));
        navigator!.goBack();
        navigator!.showSuccessMessage(
            message: local!.lockAdded,
            posAction: () {
              goBack();
            },
            posActionTitle: local!.ok);
      } catch (e) {
        navigator!.goBack();
        navigator!.showFailMessage(message: handleErrorMessage(e as Exception),
          posActionTitle: local!.tryAgain,
        );
      }
    }
  }

  void goBack() {
    navigator!.goBack();
  }
}
