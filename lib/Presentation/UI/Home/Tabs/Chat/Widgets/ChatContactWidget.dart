import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Extension/DateOnlyExtinsion.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ChatContactWidget extends StatelessWidget {
  Contact contact;
  String uid;
  Function navigationFunction;

  ChatContactWidget(
      {required this.contact,
      required this.uid,
      required this.navigationFunction,
      super.key});
  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () => navigationFunction(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(1000)),
              child: CachedNetworkImage(
                imageUrl: uid == contact.firstUserUID
                    ? contact.secondUserImage
                    : contact.firstUserImage,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uid == contact.firstUserUID
                        ? contact.secondUserName
                        : contact.firstUserName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    contact.lastMessage.isNotEmpty
                        ? contact.lastMessage
                        : uid == contact.firstUserUID
                            ? local.youAddedThisUser
                            : local.thisContactJustAddedYou,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: uid == contact.firstUserUID
                            ? contact.firstUserSentLastMessage
                                ? FontWeight.w400
                                : FontWeight.bold
                            : contact.firstUserSentLastMessage
                                ? FontWeight.bold
                                : FontWeight.w400),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              DateFormat("kk:mm").format(DateTime.fromMillisecondsSinceEpoch(contact.lastMessageTime)),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
