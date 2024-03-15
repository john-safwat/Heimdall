import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetLocksCarsUseCase.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockView.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksViewModel.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsView.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/LockCardWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/LockCardsListWdget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LocksView extends StatefulWidget {
  const LocksView({super.key});

  @override
  State<LocksView> createState() => _LocksViewState();
}

class _LocksViewState extends BaseState<LocksView, LocksViewModel>
    implements LocksNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadCardsData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          body: RefreshIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            color: Theme.of(context).scaffoldBackgroundColor,
            onRefresh: () async {
              return viewModel.loadCardsData();
            },
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "${viewModel.local!.welcomeBack} "
                        "${viewModel.appConfigProvider?.user?.displayName?.split(" ").first}"
                        " 😊",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        viewModel.local!.weAreWatchingEveryThingForYou,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: viewModel.searchController,
                        style: Theme.of(context).textTheme.bodyLarge,
                        onChanged: (value) => viewModel.search(),
                        cursorColor: Theme.of(context).primaryColor,
                        keyboardType: TextInputType.text,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            EvaIcons.search,
                            size: 30,
                          ),
                          hintText: viewModel.local!.search,
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<LocksViewModel>(
                  builder: (context, value, child) {
                    if (value.errorMessage != null) {
                      return ErrorMessageWidget(
                          errorMessage: value.errorMessage!,
                          fixErrorFunction: value.loadCardsData
                      );
                    } else if (viewModel.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (viewModel.lockCardsList.isEmpty) {
                      return Lottie.asset(viewModel.getAnimation());
                    } else {
                      return viewModel.lockCardsList.length == 1
                          ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: LockCardWidget(
                                card: viewModel.lockCardsList.first,
                                onCardClick: viewModel.onLockCardPress),
                          )
                          : LockCardsListWidget(
                              lockCardsList: viewModel.lockCardsList,
                              onLockCardPress: viewModel.onLockCardPress,
                            );
                    }
                  },
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.goToConfigureLocScreen();
            },
            child: const Icon(Bootstrap.qr_code_scan),
          ),
        ),
      ),
    );
  }

  @override
  LocksViewModel initViewModel() {
    return LocksViewModel(getLocksCarsUseCase: injectGetLocksCarsUseCase());
  }

  @override
  goToConfigureLockScreen() {
    Navigator.pushNamed(context, ConfigureLockView.routeName);
  }

  @override
  goToLockDetailsScreen(LockCard lockCard) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LockDetailsView(lockCard: lockCard)));
  }
}
