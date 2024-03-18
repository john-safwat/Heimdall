import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:provider/provider.dart';

class KeyCardWidget extends StatelessWidget {
  MyKey myKey;

  KeyCardWidget({required this.myKey, super.key});

  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: double.infinity,
                height: double.infinity,
                child: SvgPicture.asset("assets/SVG/pattern.svg", color: Theme
                    .of(context)
                    .primaryColor,),
              ),
              Positioned(child: Center(child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2000),
                  border: Border.all(width: 5 , color: Theme.of(context).primaryColor)
                ),
                child: CircleAvatar(
                  radius:30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CachedNetworkImage(
                        imageUrl: myKey.ownerImage ?? "",
                        imageBuilder: (context, imageProvider) =>
                            Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              width: 125,
                              height: 125,
                            ),
                        errorWidget: (context, url, error) =>
                            Image.asset(
                              getIcon(),
                              fit: BoxFit.cover,
                              width: 125,
                              height: 125,
                            ),
                        placeholder: (context, url) =>
                            Container(
                              width: 125,
                              height: 125,
                              decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                      ),
                    ),
                ),
              ),))
            ],
          )),
          const SizedBox(height: 10,),
          Text(myKey.lockName, style: Theme
              .of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme
              .of(context)
              .scaffoldBackgroundColor),)
        ],
      ),
    );
  }

  // function to return the icon of the app
  String getIcon() {
    if (themeProvider.getTheme() == MyTheme.blackAndWhiteTheme) {
      return "assets/images/appIcon2.png";
    } else if (themeProvider.getTheme() == MyTheme.purpleAndWhiteTheme) {
      return "assets/images/appIcon3.png";
    } else if (themeProvider.getTheme() == MyTheme.darkPurpleTheme) {
      return "assets/images/appIcon4.png";
    } else {
      return "assets/images/appIcon5.png";
    }
  }
}
