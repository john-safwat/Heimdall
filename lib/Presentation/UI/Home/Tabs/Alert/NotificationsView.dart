import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/UseCase/GetNotificationsListUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/NotificationsNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/NotificationsViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/Widgets/NotificationWidget.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/NotificationDetailsView.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState
    extends BaseState<NotificationsView, NotificationsViewModel>
    implements NotificationsNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).scaffoldBackgroundColor,
        onRefresh: () async {
          return viewModel.loadNotifications();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
              child: Text(viewModel.local!.notifications,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  )),
            ),
            Consumer<NotificationsViewModel>(
              builder: (context, value, child) {
                if (value.errorMessage != null) {
                  return SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: ErrorMessageWidget(
                        errorMessage: value.errorMessage!,
                        fixErrorFunction: value.loadNotifications
                    ),
                  );
                } else if (viewModel.loading) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (viewModel.allNotifications.isEmpty) {
                  return Lottie.asset(viewModel.getAnimation());
                } else {
                  return Expanded(
                      child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (context, index) {
                      if (viewModel.displayedData[index] is MyNotification) {
                        return NotificationWidget(
                          notification:
                              viewModel.displayedData[index] as MyNotification,
                          onNotificationClick:
                              viewModel.goToNotificationDetailsScreen,
                        );
                      } else {
                        return Text(
                          viewModel.displayedData[index] as String,
                          style: Theme.of(context).textTheme.titleLarge,
                        );
                      }
                    },
                    itemCount: viewModel.displayedData.length,
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  NotificationsViewModel initViewModel() {
    return NotificationsViewModel(
        getNotificationsListUseCase: injectGetNotificationsListUseCase());
  }

  @override
  goToNotificationDetailsScreen(MyNotification notification) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              NotificationDetailsView(notification: notification),
        ));
  }
}
