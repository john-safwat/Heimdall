import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsNavigator.dart';

class LockDetailsViewModel extends BaseViewModel<LockDetailsNavigator> {

  LockCard lockCard ;
  LockDetailsViewModel({required this.lockCard});

}