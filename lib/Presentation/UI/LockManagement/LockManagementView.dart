import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/DeleteLockUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetLocksCarsUseCase.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockView.dart';
import 'package:heimdall/Presentation/UI/LockInfo/LockInfoView.dart';
import 'package:heimdall/Presentation/UI/LockManagement/LockManagementNavigator.dart';
import 'package:heimdall/Presentation/UI/LockManagement/LockManagementViewModel.dart';
import 'package:heimdall/Presentation/UI/LockManagement/Widgets/BottomSheetOptions.dart';
import 'package:heimdall/Presentation/UI/LockPassword/LockPasswordView.dart';
import 'package:heimdall/Presentation/UI/LogList/LogListView.dart';
import 'package:heimdall/Presentation/UI/TripwireSettings/TripwireSettingsView.dart';
import 'package:heimdall/Presentation/UI/UsersList/UsersListView.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/LockCardWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/LockCardsListWdget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LockManagementView extends StatefulWidget {
  static const String routeName = "LockManagement";

  const LockManagementView({super.key});

  @override
  State<LockManagementView> createState() => _LockManagementViewState();
}

class _LockManagementViewState
    extends BaseState<LockManagementView, LockManagementViewModel>
    implements LockManagementNavigator {
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
          appBar: AppBar(
            title: Text(viewModel.local!.lockManagement),
          ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "${viewModel.local!.manageYourLocks} "
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
                const SizedBox(
                  height: 20,
                ),
                Consumer<LockManagementViewModel>(
                  builder: (context, value, child) {
                    if (value.errorMessage != null) {
                      return ErrorMessageWidget(
                          errorMessage: value.errorMessage!,
                          fixErrorFunction: value.loadCardsData);
                    } else if (viewModel.loading) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 60.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (viewModel.lockCardsList.isEmpty) {
                      return Lottie.asset(viewModel.getAnimation());
                    } else {
                      return viewModel.lockCardsList.length == 1
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
        ),
      ),
    );
  }

  @override
  LockManagementViewModel initViewModel() {
    return LockManagementViewModel(
        getLocksCarsUseCase: injectGetLocksCarsUseCase(),
        deleteLockUseCase: injectDeleteLockUseCase());
  }

  @override
  showOptionsModalBottomSheet({required LockCard card}) {
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetOptions(
              card: card,
              buttons: viewModel.buttonsData,
            ),
        backgroundColor: Colors.transparent);
  }

  @override
  goToEditLockScreen({required LockCard card}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfigureLockView(
            card: card,
          ),
        ));
    viewModel.loadCardsData();
  }

  @override
  goToChangePasswordScreen(LockCard card) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LockPasswordView(
            card: card,
          ),
        ));
  }

  @override
  goToUsersListScreen(LockCard card) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsersListView(
            card: card,
          ),
        ));
  }

  @override
  goToLogListScreen(LockCard card) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LogListView(
            card: card,
          ),
        ));
  }

  @override
  goToLockInfoScreen(LockCard card) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LockInfoView(
                  lockCard: card,
                )));
  }

  @override
  goToTripWireScreen(LockCard card) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TripwireSettingsView(
              lockCard: card,
            )));
  }
}
