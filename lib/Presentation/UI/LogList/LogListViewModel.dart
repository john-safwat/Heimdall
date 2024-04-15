import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Log/Log.dart';
import 'package:heimdall/Domain/UseCase/GetAllLogsUseCase.dart';
import 'package:heimdall/Presentation/UI/LogList/LogListNavigator.dart';

class LogListViewModel extends BaseViewModel <LogListNavigator> {

  GetAllLogsUseCase getAllLogsUseCase;
  LockCard card;
  LogListViewModel({required this.card , required this.getAllLogsUseCase});

  String? errorMessage;
  bool loading = true ;
  List<Log> logs = [];

  loadLogsData()async{

    errorMessage = null;
    loading = true;
    logs = [];
    notifyListeners();

    try{
      logs = await getAllLogsUseCase.invoke(lockId: card.lockId);
    }catch (e){
      errorMessage = handleErrorMessage(e as Exception);
    }finally {
      loading = false;
      notifyListeners();
    }
  }

  String getAnimation(){
    if(themeProvider!.getTheme() == MyTheme.blackAndWhiteTheme){
      return "assets/animations/emptyBlack.json";
    }else if (themeProvider!.getTheme() == MyTheme.purpleAndWhiteTheme){
      return "assets/animations/emptyPurple.json";
    }else if (themeProvider!.getTheme() == MyTheme.darkPurpleTheme){
      return "assets/animations/emptyDarkPurple.json";
    }else {
      return "assets/animations/emptyBlue.json";
    }
  }

}