import 'package:flutter/material.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/Models/Button/Button.dart';

class CustomButton extends StatelessWidget {
  Button button;
  CustomButton({required this.button, super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => button.onClickListener(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: button.color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                button.icon,
                size: 25,
                color: MyTheme.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              button.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Expanded(child: SizedBox()),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
