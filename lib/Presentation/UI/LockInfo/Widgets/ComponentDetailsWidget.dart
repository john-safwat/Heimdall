import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Domain/Models/Component/Component.dart';
import 'package:provider/provider.dart';

import '../../../../Core/Theme/MyTheme.dart';

class ComponentDetailsWidget extends StatelessWidget {

  Component component;
  late ThemeProvider themeProvider;
  ComponentDetailsWidget({required this.component , super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations local =  AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.7,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "${local.componentName} : ${component.name}" ??
                "lock",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(
                fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 20,),
          CachedNetworkImage(
            imageUrl: component.image,
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
            errorWidget: (context, url, error) => Image.asset(
              getIcon(),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            placeholder: (context, url) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color:
                  Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Text(
              local.description,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                  fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Text(component.description,
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor
                )
            ),
          ),
        ],
      ),
    );
  }
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
