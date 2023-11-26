import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/UseCase/AddUserUseCase.dart';
import 'package:heimdall/Domain/UseCase/CheckIfUserExistUseCase.dart';
import 'package:heimdall/Domain/UseCase/SignInWithGoogleUseCase.dart';
import 'package:heimdall/Domain/UseCase/SignUserInWithEmailAndPasswordUseCase.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoView.dart';
import 'package:heimdall/Presentation/UI/ForgetPassword/ForgetPasswordView.dart';
import 'package:heimdall/Presentation/UI/Home/HomeView.dart';
import 'package:heimdall/Presentation/UI/Login/LoginNavigator.dart';
import 'package:heimdall/Presentation/UI/Login/LoginViewModel.dart';
import 'package:heimdall/Presentation/UI/Registration/RegistrationView.dart';
import 'package:heimdall/Presentation/UI/Widgets/LanguageSwitch.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "Login";

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView, LoginViewModel>
    implements LoginNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) => Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // the white space in the top of tha screen
                        const SizedBox(
                          height: 90,
                        ),
                        // logo image
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                enableFeedback: false,
                                overlayColor:
                                    MaterialStateProperty.all(Colors.transparent),
                                onTap: value.changeTheme,
                                child: SvgPicture.asset(value.getLogo()))
                          ],
                        ),
                        // white space between the from and image
                        const SizedBox(
                          height: 70,
                        ),
                        // from to get user input
                        Form(
                          key: value.formKey,
                          child: Column(
                            children: [
                              // the text from field for the email
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyLarge,
                                controller: value.emailController,
                                validator: (value) {
                                  return viewModel!.emailValidation(value ?? "");
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  return viewModel!.passwordValidation(value ?? "");
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !value.visible,
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
                                        value.visible
                                            ? EvaIcons.eye
                                            : EvaIcons.eye_off,
                                        size: 30,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        // forget password button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: value.goToForgetPasswordScreen ,
                                child: Text(value.local!.forgetPassword)),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        // login button
                        ElevatedButton(
                            onPressed: viewModel!.signInWithEmailAndPassword,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(value.local!.login),
                                ],
                              ),
                            )
                        ),
                        const SizedBox(height: 10,),
                        // create account button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(value.local!.dontHaveAccount , style: Theme.of(context).textTheme.bodyLarge,),
                            TextButton(
                                onPressed: value.goToRegisterScreen,
                                child: Text(value.local!.createAccount)),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        // or space
                        Row(
                          children: [
                            const SizedBox(width: 30,),
                            const Expanded(child: Divider()),
                            const SizedBox(width: 10,),
                            Text(value.local!.or , style: Theme.of(context).textTheme.titleMedium,),
                            const SizedBox(width: 10,),
                            const Expanded(child: Divider()),
                            const SizedBox(width: 30,),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        // login button
                        ElevatedButton(
                            onPressed: viewModel!.loginWithGoogle,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(EvaIcons.google , color: Theme.of(context).scaffoldBackgroundColor,),
                                  const SizedBox(width: 15,),
                                  FittedBox(child: Text(value.local!.loginWithGoogle)),
                                ],
                              ),
                            )
                        ),
                        const SizedBox(height: 20,),
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
  LoginViewModel? initViewModel() {
    return LoginViewModel(
      checkIfUserExistUseCase: injectCheckIfUserExistUseCase(),
      signUserInWithEmailAndPasswordUseCase: injectSignUserInWithEmailAndPasswordUseCase(),
      addUserUseCase: injectAddUserUseCase(),
      signInWithGoogleUseCase: injectSignInWithGoogleUseCase()
    );
  }

  // function to go to registration screen
  @override
  goToRegistrationScreen() {
    Navigator.pushReplacementNamed(context, RegistrationView.routeName);
  }

  @override
  goToForgetPasswordScreen() {
    Navigator.pushNamed(context, ForgetPasswordView.routeName);
  }

  @override
  goToHomeScreen() {
    Navigator.pushReplacementNamed(context, HomeView.routeName);
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
}
