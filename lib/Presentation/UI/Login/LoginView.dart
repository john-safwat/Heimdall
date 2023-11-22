import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/Login/LoginNavigator.dart';
import 'package:heimdall/Presentation/UI/Login/LoginViewModel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {

  static const String routeName = "Login";

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView , LoginViewModel> implements LoginNavigator{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: (){viewModel!.themeProvider!.changeTheme(MyTheme.blackAndWhiteTheme);},
                child: Text(viewModel!.local!.theme0),
              ),
              ElevatedButton(
                onPressed: (){viewModel!.themeProvider!.changeTheme(MyTheme.purpleAndWhiteTheme);},
                child: Text(viewModel!.local!.theme1),
              ),
              ElevatedButton(
                onPressed: (){viewModel!.themeProvider!.changeTheme(MyTheme.darkPurpleTheme);},
                child: Text(viewModel!.local!.theme2),
              ),
              ElevatedButton(
                onPressed: (){viewModel!.themeProvider!.changeTheme(MyTheme.darkBlueTheme);},
                child: Text(viewModel!.local!.theme3),
              ),
              ElevatedButton(
                onPressed: (){viewModel!.localProvider!.changeLocal("ar");},
                child: Text(viewModel!.local!.arabic),
              ),
              ElevatedButton(
                onPressed: (){viewModel!.localProvider!.changeLocal("en");},
                child: Text(viewModel!.local!.english),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel? initViewModel() {
    return LoginViewModel();
  }
}
