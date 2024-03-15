import 'package:flutter/material.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';

class NotificationWidget extends StatelessWidget {
  MyNotification notification;
  Function onNotificationClick;

  NotificationWidget(
      {required this.notification,
      required this.onNotificationClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () => onNotificationClick(notification),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: notification.backgroundColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: MyTheme.black.withOpacity(0.3),
                      offset: const Offset(0, 0),
                      blurRadius: 10,
                    ),
                  ]),
              child: Icon(
                notification.icon,
                size: 40,
                color: notification.iconColor,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    notification.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: MyTheme.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    notification.body,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: MyTheme.black, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
