import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsNavigator.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsViewModel.dart';

class LockDetailsView extends StatefulWidget {
  static const String routeName = "LockDetails";
  LockCard? lockCard;

  LockDetailsView({this.lockCard, super.key});

  @override
  State<LockDetailsView> createState() => _LockDetailsViewState();
}

class _LockDetailsViewState
    extends BaseState<LockDetailsView, LockDetailsViewModel>
    implements LockDetailsNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          title: Text(viewModel.local!.lockDetails),
        ),
      ),
    );
  }

  @override
  LockDetailsViewModel initViewModel() {
    return LockDetailsViewModel(
      lockCard: widget.lockCard!
    );
  }
}
