import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/GetLockUsersListUseCase.dart';
import 'package:heimdall/Presentation/UI/UsersList/UsersListNavigator.dart';

class UsersListViewModel extends BaseViewModel<UsersListNavigator> {

  GetLockUsersListUseCase getLockUsersListUseCase;

  LockCard card ;
  UsersListViewModel({required this.card , required this.getLockUsersListUseCase});


  String? errorMessage;
  bool loading = true ;
  List<MyUser> users = [];

  loadUsersData()async{

    errorMessage = null;
    loading = true;
    users = [];
    notifyListeners();

    try{
      users = await getLockUsersListUseCase.invoke(lockId: card.lockId);
    }catch (e){
      errorMessage = handleErrorMessage(e as Exception);
    }finally {
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

}