import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/AddUserUseCase.dart';
import 'package:heimdall/Domain/UseCase/CreateAccountUseCase.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoView.dart';
import 'package:heimdall/Presentation/UI/Login/LoginView.dart';
import 'package:heimdall/Presentation/UI/Registration/RegistrationNavigator.dart';
import 'package:heimdall/Presentation/UI/Registration/RegistrationViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class RegistrationView extends StatefulWidget {
  static const String routeName = "Registration";
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState
    extends BaseState<RegistrationView, RegistrationViewModel>
    implements RegistrationNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<RegistrationViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(value.local!.registration),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // the white space in the top of tha screen
                        const SizedBox(
                          height: 20,
                        ),
                        // logo image
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                enableFeedback: false,
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: value.changeTheme,
                                child: SvgPicture.asset(value.getLogo()))
                          ],
                        ),
                        // white space between the from and image
                        const SizedBox(
                          height: 60,
                        ),
                        Form(
                          key: value.formKey,
                          child: Column(
                            children: [
                              // the text from field for the name
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyLarge,
                                controller: value.nameController,
                                validator: (value) {
                                  return viewModel.nameValidation(value ?? "");
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.name,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    EvaIcons.person,
                                    size: 30,
                                  ),
                                  hintText: value.local!.name,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // the text from field for the email
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyLarge,
                                controller: value.emailController,
                                validator: (value) {
                                  return viewModel
                                      .emailValidation(value ?? "");
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.emailAddress,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    EvaIcons.email,
                                    size: 30,
                                  ),
                                  hintText: value.local!.email,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // the text from field for the email
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyLarge,
                                controller: value.passwordController,
                                validator: (value) {
                                  return viewModel
                                      .passwordValidation(value ?? "");
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !value.passwordVisible,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      EvaIcons.lock,
                                      size: 30,
                                    ),
                                    hintText: value.local!.password,
                                    suffixIcon: InkWell(
                                      onTap: value.changePasswordVisibility,
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      child: Icon(
                                        value.passwordVisible
                                            ? EvaIcons.eye
                                            : EvaIcons.eye_off,
                                        size: 30,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // the text from field for the email
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyLarge,
                                controller:
                                    value.passwordConfirmationController,
                                validator: (value) {
                                  return viewModel
                                      .passwordConfirmationValidation(
                                          value ?? "");
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !value.passwordConfineVisible,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      EvaIcons.lock,
                                      size: 30,
                                    ),
                                    hintText: value.local!.passwordConfirmation,
                                    suffixIcon: InkWell(
                                      onTap:
                                          value.changePasswordConfirmVisibility,
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      child: Icon(
                                        value.passwordConfineVisible
                                            ? EvaIcons.eye
                                            : EvaIcons.eye_off,
                                        size: 30,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // login button
                        ElevatedButton(
                            onPressed: value.createAccount,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(value.local!.createAccount),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        // create account button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value.local!.alreadyHaveAccount,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextButton(
                                onPressed: value.goToLoginScreen,
                                child: Text(value.local!.login)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const LanguageSwitch()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  RegistrationViewModel initViewModel() {
    return RegistrationViewModel(
        createAccountUseCase: injectCreateAccountUseCase(),
        addUserUseCase: injectAddUserUseCase());
  }

  // function to go to extra info screen
  @override
  goToExtraInfoScreen(MyUser user) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ExtraInfoView(
                  user: user,
                )));
  }

  // function to return to login screen
  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }
}
