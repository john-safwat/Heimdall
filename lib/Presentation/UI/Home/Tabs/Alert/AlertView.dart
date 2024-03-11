import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/UseCase/GetNotificationsListUseCase.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/AlertNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/AlertViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/ThemeSlider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AlertView extends StatefulWidget {
  const AlertView({super.key});

  @override
  State<AlertView> createState() => _AlertViewState();
}

class _AlertViewState extends BaseState<AlertView , AlertViewModel> implements AlertNavigator{
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(viewModel.local!.notifications,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                )),
            Consumer<AlertViewModel>(
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
                      child: ListView.builder(
                        itemBuilder: (context, index) => const Placeholder(),
                        itemCount: viewModel.notifications.length,
                      )
                    );
                  }
                },
            )
          ],
        ),
      ),
    );
  }

  @override
  AlertViewModel initViewModel() {
    return AlertViewModel(
      getNotificationsListUseCase: injectGetNotificationsListUseCase()
    );
  }
}
