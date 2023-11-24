import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Registration/RegistrationNavigator.dart';
import 'package:heimdall/Presentation/UI/Registration/RegistrationViewModel.dart';
import 'package:provider/provider.dart';

class RegistrationView extends StatefulWidget {

  static const String routeName = "Registration";

  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends BaseState<RegistrationView , RegistrationViewModel> implements RegistrationNavigator{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<RegistrationViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(value.local!.registration),
          ),
        ),
      ),
    );
  }

  @override
  RegistrationViewModel? initViewModel() {
    return RegistrationViewModel();
  }
}
