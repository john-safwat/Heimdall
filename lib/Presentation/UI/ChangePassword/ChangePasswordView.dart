import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/UseCase/ChangePasswordUseCase.dart';
import 'package:heimdall/Presentation/UI/ChangePassword/ChangePasswordNavigator.dart';
import 'package:heimdall/Presentation/UI/ChangePassword/ChangePasswordViewModel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  static const String routeName = "ChangePassword";

  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState
    extends BaseState<ChangePasswordView, ChangePasswordViewModel>
    implements ChangePasswordNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<ChangePasswordViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.changePassword),
          ),
          body: Form(
            key: viewModel.formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(20),
              children: [
                Lottie.asset(viewModel.getResetPasswordAnimations()),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: viewModel.passwordController,
                  validator: (value) {
                    return viewModel.passwordValidation(value ?? "");
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !viewModel.passwordVisible,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        EvaIcons.lock,
                        size: 30,
                      ),
                      hintText: viewModel.local!.password,
                      suffixIcon: InkWell(
                        onTap: viewModel.changePasswordVisibility,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: Icon(
                          !viewModel.passwordVisible
                              ? EvaIcons.eye
                              : EvaIcons.eyeOff,
                          size: 30,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: viewModel.newPasswordController,
                  validator: (value) {
                    return viewModel.passwordValidation(value ?? "");
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !viewModel.newPasswordVisible,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        EvaIcons.lock,
                        size: 30,
                      ),
                      hintText: viewModel.local!.newPassword,
                      suffixIcon: InkWell(
                        onTap: viewModel.changeNewPasswordVisibility,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: Icon(
                          !viewModel.newPasswordVisible
                              ? EvaIcons.eye
                              : EvaIcons.eyeOff,
                          size: 30,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: viewModel.newPasswordConfirmationController,
                  validator: (value) {
                    return viewModel
                        .passwordConfirmationValidation(value ?? "");
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !viewModel.newPasswordConfirmationVisible,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        EvaIcons.lock,
                        size: 30,
                      ),
                      hintText: viewModel.local!.newPasswordConfirmation,
                      suffixIcon: InkWell(
                        onTap:
                            viewModel.changeNewPasswordConfirmationVisibility,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: Icon(
                          !viewModel.newPasswordConfirmationVisible
                              ? EvaIcons.eye
                              : EvaIcons.eyeOff,
                          size: 30,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {viewModel.updatePassword();},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        viewModel.local!.changePassword,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ChangePasswordViewModel initViewModel() {
    return ChangePasswordViewModel(
      changePasswordUseCase: injectChangePasswordUseCase()
    );
  }
}
