import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetLockPasswordUserCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateLockPasswordUseCase.dart';
import 'package:heimdall/Presentation/UI/LockPassword/LockPasswordNavigator.dart';

class LockPasswordViewModel extends BaseViewModel<LockPasswordNavigator> {
  GetLockPasswordUserCase getLockPasswordUserCase;
  UpdateLockPasswordUseCase updateLockPasswordUseCase;
  LockCard card;

  LockPasswordViewModel(
      {required this.card,
      required this.getLockPasswordUserCase,
      required this.updateLockPasswordUseCase});

  String password = "";
  String? errorMessage;
  bool loading = true;

  List<List<String>> buttonsTitle = [
    ["1", "2", "3", "A"],
    ["4", "5", "6", "B"],
    ["7", "8", "9", "C"],
    ["*", "0", "#", "D"],
  ];

  loadPassword() async {
    password = "";
    errorMessage = null;
    loading = true;
    notifyListeners();
    try {
      password = await getLockPasswordUserCase.invoke(lockId: card.lockId);
    } catch (e) {
      errorMessage = handleErrorMessage(e as Exception);
    } finally {
      notifyListeners();
      loading = false;
    }
  }

  updatePassword(String buttonTitle) {
    password = password + buttonTitle;
    notifyListeners();
  }

  confirmPassword() {
    navigator!.showQuestionMessage(
        message: local!.areYouSure,
        posActionTitle: local!.ok,
        negativeActionTitle: local!.cancel,
        posAction: changeLockPassword);
  }

  changeLockPassword() async {
    navigator!.showLoading(message: local!.loading);
    try {
      await updateLockPasswordUseCase.invoke(
          lockId: card.lockId, password: password);
      navigator!.goBack();
      navigator!.showSuccessMessage(
          message: local!.passwordUpdateSuccessfully,
          posActionTitle: local!.ok);
    } catch (e) {
      navigator!.goBack();
      navigator!.showFailMessage(
          message: handleErrorMessage(e as Exception),
          posActionTitle: local!.ok);
    }
  }

  clearPassword() {
    password = "";
    notifyListeners();
  }

  deleteDigitFromPassword() {
    if (password.isEmpty) {
      return;
    }
    password = password.substring(0, password.length - 1);
    notifyListeners();
  }
}
