import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetLockPasswordUserCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateLockPasswordUseCase.dart';
import 'package:heimdall/Presentation/UI/LockPassword/LockPasswordNavigator.dart';
import 'package:heimdall/Presentation/UI/LockPassword/LockPasswordViewModel.dart';
import 'package:heimdall/Presentation/UI/LockPassword/Widgets/PasswordButton.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:provider/provider.dart';

class LockPasswordView extends StatefulWidget {
  static const String routeName = "LockPassword";

  LockCard? card;

  LockPasswordView({this.card, super.key});

  @override
  State<LockPasswordView> createState() => _LockPasswordViewState();
}

class _LockPasswordViewState
    extends BaseState<LockPasswordView, LockPasswordViewModel>
    implements LockPasswordNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadPassword();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(viewModel.local!.changeLockPassword),
        ),
        body: Consumer<LockPasswordViewModel>(
          builder: (context, value, child) {
            if (value.errorMessage != null) {
              return ErrorMessageWidget(
                  errorMessage: value.errorMessage!,
                  fixErrorFunction: viewModel.loadPassword);
            } else if (value.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            // color: Theme.of(context).primaryColor,
                            border: Border.all(
                              width: 3,
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: Text(
                          value.password,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    // color: Theme.of(context).scaffoldBackgroundColor
                                  ),
                        ),
                      )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: viewModel.buttonsTitle[0]
                          .map((e) => PasswordButton(
                                title: e,
                                onPress: viewModel.updatePassword,
                              ))
                          .toList(),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: viewModel.buttonsTitle[1]
                          .map((e) => PasswordButton(
                                title: e,
                                onPress: viewModel.updatePassword,
                              ))
                          .toList(),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: viewModel.buttonsTitle[2]
                          .map((e) => PasswordButton(
                                title: e,
                                onPress: viewModel.updatePassword,
                              ))
                          .toList(),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: viewModel.buttonsTitle[3]
                          .map((e) => PasswordButton(
                                title: e,
                                onPress: viewModel.updatePassword,
                              ))
                          .toList(),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)))),
                                  onPressed: () => viewModel.confirmPassword(),
                                  child: Text(
                                    viewModel.local!.confirm,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)))),
                                  onPressed: () =>
                                      viewModel.deleteDigitFromPassword(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      "assets/SVG/back.svg",
                                      width: double.infinity,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)))),
                                  onPressed: () => viewModel.clearPassword(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      "assets/SVG/deleteAccountIcon.svg",
                                      width: double.infinity,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  )),
                            ),
                          )
                        ]),
                  )),
                ],
              );
            }
          },
        ),
      )),
    );
  }

  @override
  LockPasswordViewModel initViewModel() {
    return LockPasswordViewModel(
        card: widget.card!,
        getLockPasswordUserCase: injectGetLockPasswordUserCase(),
        updateLockPasswordUseCase: injectUpdateLockPasswordUseCase());
  }
}
