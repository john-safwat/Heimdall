import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/CreateKey/ManageKeyViewModel.dart';
import 'package:provider/provider.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ManageKeyViewModel provider = Provider.of<ManageKeyViewModel>(context);
    return InkWell(
      onTap: () => provider.showRangeTimePicker(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 8),
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
                    provider.local!.from,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
                const SizedBox(width: 6,),
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                          provider.rangeTime.startTime.format(context),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                      ),
                    )
                ),
              ],
            ),
            const SizedBox(height: 12,),
            Row(children: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                        provider.rangeTime.endTime.format(context),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                    ),
                  )
              ),
              const SizedBox(width: 6,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  provider.local!.to,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            ],)
          ],
        ),
      ),
    );
  }
}
