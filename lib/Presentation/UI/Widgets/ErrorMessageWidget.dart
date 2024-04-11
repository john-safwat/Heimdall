import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class ErrorMessageWidget extends StatelessWidget {
  String errorMessage;
  Function fixErrorFunction;
  ErrorMessageWidget({required this.errorMessage ,required this.fixErrorFunction , super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/animations/errorImage.json" ,width: double.infinity ,fit: BoxFit.contain),
          const SizedBox(height: 10,),
          Text(errorMessage , style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () => fixErrorFunction(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10),
              child: Text(local.tryAgain),
            ),
          ),
        ],
      ),
    );
  }
}
