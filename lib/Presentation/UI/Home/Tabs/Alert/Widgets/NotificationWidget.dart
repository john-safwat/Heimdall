import 'package:flutter/material.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';

class NotificationWidget extends StatelessWidget {
  MyNotification notification;
  Function onNotificationClick;
  Function getBackgroundColor;
  Function getIconColor;
  Function getIcon;

  NotificationWidget(
      {required this.notification,
      required this.onNotificationClick,
      required this.getBackgroundColor,
      required this.getIconColor,
      required this.getIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: getBackgroundColor(notification.priority),
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
                  color: MyTheme.black.withOpacity(0.5),
                  offset: const Offset(0,0),
                  blurRadius: 10,
                ),
              ]
            ),
            child: Icon(getIcon(notification.priority ),size: 40, color: getIconColor(notification.priority),),
          )
        ],
      ),
    );
  }
}
