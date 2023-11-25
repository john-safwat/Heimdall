import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoNavigator.dart';
import 'package:heimdall/Presentation/UI/ExtraInfo/ExtraInfoViewModel.dart';
import 'package:provider/provider.dart';

class ExtraInfoView extends StatefulWidget {

  static const String routeName = "ExtraInfo";

  MyUser user;
  ExtraInfoView({required this.user , super.key});

  @override
  State<ExtraInfoView> createState() => _ExtraInfoViewState();
}

class _ExtraInfoViewState extends BaseState<ExtraInfoView , ExtraInfoViewModel> implements ExtraInfoNavigator {

  @override
  void initState() {
    super.initState();
    viewModel!.user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<ExtraInfoViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(),
        ),
      ),
    );
  }

  @override
  ExtraInfoViewModel? initViewModel() {
    return ExtraInfoViewModel();
  }
}
