import 'package:flutter/material.dart';

class PasswordButton extends StatelessWidget {

  String title;
  Function onPress;
  PasswordButton({required this.title , required this.onPress , super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ))
          ),
            onPressed: () =>
                onPress(title),
            child: Text(title , style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).scaffoldBackgroundColor), )),
      ),
    );
  }
}
