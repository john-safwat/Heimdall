import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Core/Providers/LocksProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/UseCase/ChangeLockStateUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetUserDataUseCase.dart';
import 'package:heimdall/Domain/UseCase/SetLockRealTimeDatabaseListenerUseCase.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/KeyDetailsNavigator.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/KeyDetailsViewModel.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/Widgets/DateWidget.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/Widgets/TimeWidget.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/Widgets/WeekDays.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/UserCardWidget.dart';
import 'package:provider/provider.dart';

class KeyDetailsView extends StatefulWidget {
  static const String routeName = "KeyDetails";
  EKey? myKey;

  KeyDetailsView({this.myKey, super.key});

  @override
  State<KeyDetailsView> createState() => _KeyDetailsViewState();
}

class _KeyDetailsViewState
    extends BaseState<KeyDetailsView, KeyDetailsViewModel>
    implements KeyDetailsNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.locksProvider =
        Provider.of<LocksProvider>(context, listen: false);
    viewModel.locksProvider.lockId = viewModel.key.lockId!;
    viewModel.setDatabaseListener();
    viewModel.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.keyDetails),
          ),
          body: Consumer<KeyDetailsViewModel>(
            builder:(context, value, child) {
              if (value.errorMessage != null) {
                return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ErrorMessageWidget(
                      errorMessage: value.errorMessage!,
                      fixErrorFunction: value.loadUserData
                  ),
                );
              } else if (value.user == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Text(
                      viewModel.local!.youCanUseThisKey,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TimeWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                viewModel.locksProvider.value["opened"] != null &&
                                    viewModel.locksProvider.value["opened"]
                                    ? MyTheme.green
                                    : MyTheme.red)),
                        onPressed: () {

                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewModel.locksProvider.value["opened"] != null &&
                                    viewModel.locksProvider.value["opened"]
                                    ? viewModel.local!.opened
                                    : viewModel.local!.closed,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: MyTheme.white),
                              ),
                              Switch(
                                activeColor: MyTheme.white,
                                inactiveThumbColor: MyTheme.black,
                                inactiveTrackColor: MyTheme.white,
                                value: viewModel.locksProvider.value["opened"] ?? false,
                                onChanged: (value) => () {
                                  viewModel.changeLockState();
                                },
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      viewModel.key.lockName,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          const Expanded(child: Divider()),
                          const SizedBox(width: 20),
                          Text(
                            viewModel.local!.validIn,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 20),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const DateWidget(),
        
                    if(value.key.days!.isNotEmpty)...[
                      const SizedBox(height: 20),
                      const WeekDays(),
                    ],
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          const Expanded(child: Divider()),
                          const SizedBox(width: 20),
                          Text(
                            viewModel.local!.by,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 20),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    UserCardWidget(user: viewModel.user!)
                  ],
                );
              }
        
            },
          ),
        ),
      ),
    );
  }

  @override
  KeyDetailsViewModel initViewModel() {
    return KeyDetailsViewModel(
        key: widget.myKey!,
        setLockRealTimeDatabaseListenerUseCase:
            injectSetLockRealTimeDatabaseListenerUseCase(),
    changeLockStateUseCase: injectChangeLockStateUseCase(),
    getUserDataUseCase: injectGetUserDataUseCase());
  }
}
