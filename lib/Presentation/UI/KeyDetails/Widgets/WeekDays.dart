import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/KeyDetailsViewModel.dart';
import 'package:provider/provider.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({super.key});

  @override
  Widget build(BuildContext context) {
    KeyDetailsViewModel provider = Provider.of<KeyDetailsViewModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: provider.days.map((e) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: provider.key.days!.contains(e)? Theme.of(context).primaryColor:Colors.transparent,
          borderRadius: BorderRadius.circular(2000),
          border: Border.all(width: 2 , color: Theme.of(context).primaryColor),
        ),
        child: FittedBox(
          child: Text(e , style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: provider.key.days!.contains(e)?  Theme.of(context).scaffoldBackgroundColor: Theme.of(context).primaryColor
          )),
        ),
      )).toList(),
    );
  }
}
