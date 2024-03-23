import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/CreateKey/ManageKeyViewModel.dart';
import 'package:heimdall/Presentation/UI/CreateKey/Widgets/WeekDaysPicker.dart';
import 'package:heimdall/Presentation/UI/KeyDetails/KeyDetailsViewModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    KeyDetailsViewModel provider = Provider.of<KeyDetailsViewModel>(context);
    if (provider.key.validOnce??true) {
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
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(DateFormat("yMd").format(provider.key.startDate!),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!),
                ))
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Container(
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
                          DateFormat("yMd").format(provider.key.startDate!),
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
                          DateFormat("yMd").format(provider.key.endDate!),
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
          const SizedBox(height: 20),
          const WeekDaysPicker(),
        ],
      );
    }
  }
}
