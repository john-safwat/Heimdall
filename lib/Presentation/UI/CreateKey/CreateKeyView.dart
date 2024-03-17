import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/CreateKey/CreateKeyNavigator.dart';
import 'package:heimdall/Presentation/UI/CreateKey/CreateKeyViewModel.dart';

class CreateKeyView extends StatefulWidget {
  static const String routeName = "CreateKy";
  const CreateKeyView({super.key});

  @override
  State<CreateKeyView> createState() => _CreateKeyViewState();
}

class _CreateKeyViewState extends BaseState<CreateKeyView , CreateKeyViewModel> implements CreateKeyNavigator {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  CreateKeyViewModel initViewModel() {
    return CreateKeyViewModel();
  }
}
