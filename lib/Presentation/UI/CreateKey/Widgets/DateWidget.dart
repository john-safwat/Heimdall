import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/CreateKey/ManageKeyViewModel.dart';
import 'package:heimdall/Presentation/UI/CreateKey/Widgets/WeekDaysPicker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ManageKeyViewModel provider = Provider.of<ManageKeyViewModel>(context);
    if (provider.validOnce) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                provider.local!.date,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ),
            Expanded(
                child: InkWell(
              onTap: () => provider.showRangeDatePicker(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(DateFormat("yMd").format(provider.singleDate),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!),
              ),
            ))
          ],
        ),
      );
    } else {
      return Column(
        children: [
          InkWell(
            onTap: () => provider.showRangeDatePicker(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          provider.local!.start,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                            DateFormat("yMd").format(provider.rangeDate.start),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium!),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                            DateFormat("yMd").format(provider.rangeDate.end),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium!),
                      )),
                      const SizedBox(
                        width: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          provider.local!.end,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const WeekDaysPicker(),
        ],
      );
    }
  }
}
