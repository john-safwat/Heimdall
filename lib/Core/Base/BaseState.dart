import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Errors/FirebaseAuthExceptionHandler.dart';
import 'package:heimdall/Core/Errors/FirebaseFireStoreErrorHandler.dart';
import 'package:heimdall/Core/Errors/FirebaseImageDatabaseExceptionsHandler.dart';
import 'package:heimdall/Core/Errors/FirebaseLoginErrorHandler.dart';
import 'package:heimdall/Core/Errors/LocalAuthExceptionHandler.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Core/Utils/DialogUtils.dart';
import 'package:provider/provider.dart';

abstract class BaseState<T extends StatefulWidget , VM extends BaseViewModel> extends State<T> implements  BaseNavigator{

  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
    viewModel.appConfigProvider = Provider.of<AppConfigProvider>(context , listen: false);
    viewModel.firebaseLoginErrorHandler = injectFirebaseLoginErrorHandler();
    viewModel.firebaseAuthExceptionHandler = injectFirebaseAuthExceptionHandler();
    viewModel.firebaseFireStoreErrorHandler = injectFirebaseFireStoreErrorHandler();
    viewModel.firebaseImageDatabaseExceptionsHandler = injectFirebaseImageDatabaseExceptionsHandler();
    viewModel.localAuthExceptionHandler = injectLocalAuthExceptionHandler();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.navigator = null ;
    viewModel.appConfigProvider = null;
    viewModel.themeProvider = null ;
    viewModel.localProvider =null;
  }

  VM initViewModel();

  // override function Build to set the themeProvider , localProvider , local and mediaQuery in all screens auto
  @override
  Widget build(BuildContext context) {
    viewModel.themeProvider = Provider.of<ThemeProvider>(context);
    viewModel.localProvider = Provider.of<LocalProvider>(context);
    viewModel.local = AppLocalizations.of(context)!;
    viewModel.mediaQuery = MediaQuery.of(context).size;
    return const SizedBox();
  }

  // function to pop the last context in widget tree
  @override
  goBack() {
    Navigator.pop(context);
  }


  @override
  showFailMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction,}) {
    MyDialogUtils.showFailMessage(
      context: context,
      message: message,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }

  @override
  showLoading({required String message,}) {
    MyDialogUtils.showLoadingDialog(
      context: context,
      message: message,
    );
  }

  @override
  showQuestionMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction,}) {
    MyDialogUtils.showQuestionMessage(
      context: context,
      message: message,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }

  @override
  showSuccessMessage({required String message, String? posActionTitle, VoidCallback? posAction, String? negativeActionTitle, VoidCallback? negativeAction,}) {
    MyDialogUtils.showSuccessMessage(
      context: context,
      message: message,
      negativeActionTitle: negativeActionTitle,
      posActionTitle: posActionTitle,
      posAction: posAction,
      negativeAction: negativeAction,
    );
  }

  @override
  showSuccessNotification({required String message}){
    ElegantNotification(
      icon: const Icon(EvaIcons.checkmarkCircle , color: MyTheme.white,),
      description: Text(message , style: Theme.of(context).textTheme.titleSmall!.copyWith(color: MyTheme.white),),
      background: Colors.green,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: viewModel.mediaQuery!.width,
      borderRadius: BorderRadius.circular(15),
      height: 50,
    ).show(context);
  }

  @override
  showErrorNotification({required String message}){
    ElegantNotification(
      icon: const Icon(EvaIcons.closeCircle , color: MyTheme.white,),
      description: Text(message , style: Theme.of(context).textTheme.titleSmall!.copyWith(color: MyTheme.white),),
      background: Colors.red,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: viewModel.mediaQuery!.width,
      borderRadius: BorderRadius.circular(15),
      height: 50,
    ).show(context);
  }

  @override
  showCustomNotification({
    required IconData iconData,
    required String message ,
    required Color background ,
    required double height
  }){
    ElegantNotification(
      icon:Icon(iconData , color: MyTheme.white,),
      description: Text(message , style: Theme.of(context).textTheme.titleSmall!.copyWith(color: MyTheme.white)),
      background: background,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: viewModel.mediaQuery!.width,
      borderRadius: BorderRadius.circular(15),
      height: height,
    ).show(context);
  }


  // show modal bottom sheet to read image from user
  @override
  showCustomModalBottomSheet({required Widget widget}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => widget,
    );
  }


}
