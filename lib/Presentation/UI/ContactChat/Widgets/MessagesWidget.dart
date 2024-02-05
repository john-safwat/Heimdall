import 'package:flutter/material.dart';
import 'package:heimdall/Core/Providers/AppConfigProvider.dart';
import 'package:heimdall/Domain/Models/Chat/Chat.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {

  Chat message;
  MessageWidget({required this.message,super.key});

  @override
  Widget build(BuildContext context) {
    AppConfigProvider appConfigProvider = Provider.of<AppConfigProvider>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: appConfigProvider.user!.uid == message.senderID? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(10),
          constraints: BoxConstraints(minWidth: 0, maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration:BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft:const Radius.circular(15),
                  bottomRight: const Radius.circular(15),
                  topRight: appConfigProvider.user!.uid == message.senderID?const Radius.circular(0) :const Radius.circular(15),
                  topLeft: appConfigProvider.user!.uid == message.senderID?const Radius.circular(15) :const Radius.circular(0)
              )
          ),
          child: Text(message.messageContent , style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).scaffoldBackgroundColor),),
        ),
      ],
    );
  }
}