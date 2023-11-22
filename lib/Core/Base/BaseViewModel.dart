import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {

  N? navigator ;

  ThemeProvider? themeProvider;
  LocalProvider? localProvider;
  AppConfigProvider? appConfigProvider ;
  AppLocalizations? local ;
  Size? mediaQuery;


}