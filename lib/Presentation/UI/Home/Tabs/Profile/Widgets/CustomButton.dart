import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: button.color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset(
                button.icon,
                width: 26,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            button.description.isEmpty
                ? Text(
                    button.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor),
                    textAlign: TextAlign.start,
                  )
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          button.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          button.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.7)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
