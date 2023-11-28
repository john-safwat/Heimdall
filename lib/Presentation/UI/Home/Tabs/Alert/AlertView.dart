import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/AlertNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Alert/AlertViewModel.dart';

class AlertView extends StatefulWidget {
  const AlertView({super.key});

  @override
  State<AlertView> createState() => _AlertViewState();
}

class _AlertViewState extends BaseState<AlertView , AlertViewModel> implements AlertNavigator{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.red,
    );
  }

  @override
  AlertViewModel? initViewModel() {
    return AlertViewModel();
  }
}
