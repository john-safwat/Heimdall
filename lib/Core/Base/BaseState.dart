import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Core/Base/BaseViewModel.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseState<T extends StatefulWidget , VM extends BaseViewModel> extends State<T> implements  BaseNavigator{

  VM? viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel!.navigator = this;
    viewModel!.appConfigProvider = Provider.of<AppConfigProvider>(context , listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel!.navigator = null ;
    viewModel!.appConfigProvider = null;
    viewModel!.themeProvider = null ;
    viewModel!.localProvider =null;
    viewModel =null;
  }

  VM? initViewModel();

  @override
  Widget build(BuildContext context) {
    viewModel!.themeProvider = Provider.of<ThemeProvider>(context);
    viewModel!.localProvider = Provider.of<LocalProvider>(context);
    viewModel!.local = AppLocalizations.of(context)!;
    viewModel!.mediaQuery = MediaQuery.of(context).size;
    return const SizedBox();
  }

}
