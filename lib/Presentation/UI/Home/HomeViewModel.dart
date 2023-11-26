import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/HomeNavigator.dart';

class HomeViewModel extends BaseViewModel <HomeNavigator> {

  int selectedIndex = 0;

  changeIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }

}