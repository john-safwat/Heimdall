import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  String lable;
  Function todo;
  ProfileButton({required this.todo,required this.lable,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: todo(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(lable),
              ],
            ),
          )),
    );
  }
}
