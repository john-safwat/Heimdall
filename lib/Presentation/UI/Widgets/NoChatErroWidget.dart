import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoChatErrorWidget extends StatelessWidget {
  NoChatErrorWidget(
      {required this.errorMessage, required this.image, super.key});
  String image;
  String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(image, width: double.infinity, height: 250),
        Text(
          textAlign: TextAlign.center,
          errorMessage,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
