import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/CreateKey/ManageKeyViewModel.dart';
import 'package:provider/provider.dart';

class WeekDaysPicker extends StatelessWidget {
  const WeekDaysPicker({super.key});

  @override
  Widget build(BuildContext context) {
    ManageKeyViewModel provider = Provider.of<ManageKeyViewModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: provider.days.map((e) => InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () => provider.onDayClick(e),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: provider.selectedDays.contains(e)? Theme.of(context).primaryColor:Colors.transparent,
            borderRadius: BorderRadius.circular(2000),
            border: Border.all(width: 2 , color: Theme.of(context).primaryColor),
          ),
          child: FittedBox(
            child: Text(e , style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: provider.selectedDays.contains(e)?  Theme.of(context).scaffoldBackgroundColor: Theme.of(context).primaryColor
            )),
          ),
        ),
      )).toList(),
    );
  }
}
