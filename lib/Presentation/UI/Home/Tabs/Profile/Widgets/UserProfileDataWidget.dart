import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileDataWidget extends StatelessWidget {
  bool isEn;

  User user;
  String buttonTitle;
  Function getIcon;
  Function buttonAction;

  UserProfileDataWidget(
      {required this.user,
      required this.isEn,
      required this.buttonTitle,
      required this.buttonAction,
      required this.getIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        buttonAction();
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft:
                  isEn ? const Radius.circular(80) : const Radius.circular(0),
              bottomRight:
                  isEn ? const Radius.circular(0) : const Radius.circular(80),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // user image
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: const Radius.circular(80),
                        bottomLeft: const Radius.circular(80),
                        topLeft: isEn
                            ? const Radius.circular(15)
                            : const Radius.circular(80),
                        topRight: isEn
                            ? const Radius.circular(80)
                            : const Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 10)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: const Radius.circular(80),
                      bottomLeft: const Radius.circular(80),
                      topLeft: isEn
                          ? const Radius.circular(15)
                          : const Radius.circular(80),
                      topRight: isEn
                          ? const Radius.circular(80)
                          : const Radius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: user.photoURL ?? "",
                      imageBuilder: (context, imageProvider) => Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        width: 125,
                        height: 125,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        getIcon(),
                        fit: BoxFit.cover,
                        width: 125,
                        height: 125,
                      ),
                      placeholder: (context, url) => Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            // user name , email and edit profile button
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  user.displayName ?? "No Name",
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                const Spacer(),
                FittedBox(
                    child: Text(
                  user.email ?? "No Email",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                )),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    buttonAction();
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).scaffoldBackgroundColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          buttonTitle,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
