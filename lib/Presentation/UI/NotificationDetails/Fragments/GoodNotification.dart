import 'package:flutter/material.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/NotificationDetailsViewModel.dart';
import 'package:heimdall/Presentation/UI/Widgets/LockCardWidget.dart';
import 'package:provider/provider.dart';

class GoodNotification extends StatelessWidget {
  GoodNotification({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationDetailsViewModel provider = Provider.of<NotificationDetailsViewModel>(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(provider.notification.body , style: Theme.of(context).textTheme.titleMedium,),
        const SizedBox(height: 20,),
        LockCardWidget(card: provider.card, onCardClick: provider.onLockCardPress),
        const SizedBox(height: 20,),
        Text(provider.local!.notificationMessage , style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.justify,),
      ],
    );
  }
}
