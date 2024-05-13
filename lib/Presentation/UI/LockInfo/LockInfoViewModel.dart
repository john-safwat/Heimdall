import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Component/Component.dart';
import 'package:heimdall/Domain/Models/Model/Model.dart';
import 'package:heimdall/Domain/UseCase/GetLockModelUseCase.dart';
import 'package:heimdall/Presentation/UI/LockInfo/LockInfoNavigator.dart';
import 'package:heimdall/Presentation/UI/LockInfo/Widgets/ComponentDetailsWidget.dart';

class LockInfoViewModel extends BaseViewModel<LockInfoNavigator> {

  LockCard lockCard;
  GetLockModelUseCase getLockModelUseCase;
  LockInfoViewModel({required this.lockCard , required this.getLockModelUseCase});

  late Model model;
  String? errorMessage;
  bool loading = true;

  loadData()async{
    errorMessage = null;
    loading = true;
    notifyListeners();
    try{
      model = await getLockModelUseCase.invoke(lockId: lockCard.lockId);
      loading = false;
      notifyListeners();

    }catch(e){
      errorMessage = handleErrorMessage(e as Exception);
      loading = false;
      notifyListeners();
    }
  }


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

  onComponentClick(Component component){
    navigator!.showCustomModalBottomSheet(widget: ComponentDetailsWidget(component: component,));
  }
}