import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Core/Utils/DialogUtils.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseState<T extends StatefulWidget , VM extends BaseViewModel> extends State<T> implements  BaseNavigator{

  VM? viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel!.navigator = this;
    viewModel!.appConfigProvider = Provider.of<AppConfigProvider>(context , listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel!.navigator = null ;
    viewModel!.appConfigProvider = null;
    viewModel!.themeProvider = null ;
    viewModel!.localProvider =null;
    viewModel =null;
  }

  VM? initViewModel();

  // override function Build to set the themeProvider , localProvider , local and mediaQuery in all screens auto
  @override
  Widget build(BuildContext context) {
    viewModel!.themeProvider = Provider.of<ThemeProvider>(context);
    viewModel!.localProvider = Provider.of<LocalProvider>(context);
    viewModel!.local = AppLocalizations.of(context)!;
    viewModel!.mediaQuery = MediaQuery.of(context).size;
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
      icon:const Icon(Bootstrap.check , color: MyTheme.white,),
      description: Text(message , style: Theme.of(context).textTheme.titleSmall!.copyWith(color: MyTheme.white),),
      background: Colors.green,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: viewModel!.mediaQuery!.width,
      radius: 15,
      height: 50,
    ).show(context);
  }

  @override
  showErrorNotification({required String message}){
    ElegantNotification(
      icon:const Icon(Bootstrap.x_circle , color: MyTheme.white,),
      description: Text(message , style: Theme.of(context).textTheme.titleSmall!.copyWith(color: MyTheme.white),),
      background: Colors.red,
      animation: AnimationType.fromTop,
      displayCloseButton: false,
      progressIndicatorBackground: Colors.transparent,
      showProgressIndicator: false,
      width: viewModel!.mediaQuery!.width,
      radius: 15,
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
      width: viewModel!.mediaQuery!.width,
      radius: 15,
      height: height,
    ).show(context);
  }


  // show modal bottom sheet to read image from user
  @override
  showImagePickerModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(viewModel!.local!.pickYourImagePickingMethod , style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: viewModel!.pickImageFromCamera,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(viewModel!.local!.camera),
                      )
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: ElevatedButton(
                      onPressed: viewModel!.pickImageFromGallery,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(viewModel!.local!.gallery),
                      )
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


}
