import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/GetUserDataUseCase.dart';
import 'package:heimdall/Presentation/UI/UpdateProfile/UpdateProfileNavigator.dart';

class UpdateProfileViewModel extends BaseViewModel<UpdateProfileNavigator> {

  GetUserDataUseCase getUserDataUseCase;
  UpdateProfileViewModel({required this.getUserDataUseCase});

  MyUser? user;
  String? errorMessage;

  // function to update user
  loadUserData()async{
    user = null;
    errorMessage = null;
    notifyListeners();

    try{
      user = await getUserDataUseCase.invoke(uid: appConfigProvider!.user!.uid);
      notifyListeners();
    }catch(e){
      errorMessage = handleErrorMessage(e as Exception);
      notifyListeners();
    }

  }

}