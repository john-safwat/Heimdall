import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/UseCase/GetCardUseCase.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewView.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsView.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/Fragments/DangerNotification.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/Fragments/GoodNotification.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/Fragments/WarningNotification.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/NotificationDetailsNavigator.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/NotificationDetailsViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:provider/provider.dart';

class NotificationDetailsView extends StatefulWidget {
  static const String routeName = "NotificationDetails";
  MyNotification? notification;

  NotificationDetailsView({this.notification, super.key});

  @override
  State<NotificationDetailsView> createState() =>
      _NotificationDetailsViewState();
}

class _NotificationDetailsViewState
    extends BaseState<NotificationDetailsView, NotificationDetailsViewModel>
    implements NotificationDetailsNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.notification.title),
        ),
        body: Consumer<NotificationDetailsViewModel>(
          builder: (context, value, child) {
            if(value.errorMessage != null){
              return SingleChildScrollView(
                child: ErrorMessageWidget(
                    errorMessage: value.errorMessage!,
                    fixErrorFunction: value.loadData
                ),
              );
            }else if (value.loading){
              return const Center(child: CircularProgressIndicator(),);
            }else {
              if (value.notification.code >= 100 &&
                  value.notification.code < 200) {
                return GoodNotification();
              } else if (value.notification.code >= 200 &&
                  value.notification.code < 300) {
                return WarningNotification();
              } else {
                return DangerNotification();
              }
            }
          },
        ),
      ),
    );
  }

  @override
  NotificationDetailsViewModel initViewModel() {
    return NotificationDetailsViewModel(
      notification: widget.notification!,
      getCardUseCase: injectGetCardUseCase()
    );
  }
  @override
  goToLockDetailsScreen(LockCard lockCard) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LockDetailsView(lockCard: lockCard)));
  }

  @override
  goToImagePreviewScreen(
      {required String image,
        required String tag,
        required List<String> images}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ImagePreviewView(tag: tag, image: image, images: images),
        ));
  }
}
