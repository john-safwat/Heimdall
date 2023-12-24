import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/LockManagement/LockManagementNavigator.dart';
import 'package:heimdall/Presentation/UI/LockManagement/LockManagementViewModel.dart';
import 'package:provider/provider.dart';

class LockManagementView extends StatefulWidget {
  static const String routeName = "LockManagement";
  const LockManagementView({super.key});

  @override
  State<LockManagementView> createState() => _LockManagementViewState();
}

class _LockManagementViewState extends BaseState<LockManagementView , LockManagementViewModel> implements LockManagementNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Scaffold(
        appBar: AppBar(title: Text("LockManagement"),),
      ),
    );
  }

  @override
  LockManagementViewModel? initViewModel() {
    return LockManagementViewModel();
  }
}