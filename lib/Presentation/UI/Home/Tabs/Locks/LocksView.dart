import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/ThemeSlider.dart';

class LocksView extends StatefulWidget {
  const LocksView({super.key});

  @override
  State<LocksView> createState() => _LocksViewState();
}

class _LocksViewState extends BaseState<LocksView , LocksViewModel> implements LocksNavigator {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ThemeSwitch(),
    );
  }

  @override
  LocksViewModel initViewModel() {
    return LocksViewModel();
  }
}
