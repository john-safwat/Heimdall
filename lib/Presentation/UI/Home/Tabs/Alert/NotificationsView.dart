import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/UseCase/GetNotificationsListUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/NotificationsNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/NotificationsViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/Widgets/NotificationWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends BaseState<NotificationsView , NotificationsViewModel> implements NotificationsNavigator{
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20 , 20 , 0),
            child: Text(viewModel.local!.notifications,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                )),
          ),
          Consumer<NotificationsViewModel>(
              builder: (context, value, child) {
                if(value.errorMessage != null){
                  return Column(
                    children: [
                      const Row(),
                      Text(
                        viewModel.errorMessage!,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            viewModel.loadNotifications();
                          },
                          child: Text(viewModel.local!.tryAgain))
                    ],
                  );
                } else if (viewModel.loading) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                } else if (viewModel.notifications.isEmpty) {
                  return Lottie.asset(viewModel.getAnimation());
                } else {
                  return  Expanded(
                    child: ListView.separated(
                      padding:const EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
                      separatorBuilder: (context, index) => const SizedBox(height: 10,),
                      itemBuilder: (context, index) => NotificationWidget(
                          notification: viewModel.notifications[index],
                          onNotificationClick: viewModel.goToNotificationDetailsScreen,
                        getBackgroundColor: viewModel.getBackgroundColor,
                        getIconColor: viewModel.getIconColor,
                        getIcon: viewModel.getIcon,
                      ),
                      itemCount: viewModel.notifications.length,
                    )
                  );
                }
              },
          )
        ],
      ),
    );
  }

  @override
  NotificationsViewModel initViewModel() {
    return NotificationsViewModel(
      getNotificationsListUseCase: injectGetNotificationsListUseCase()
    );
  }
}
