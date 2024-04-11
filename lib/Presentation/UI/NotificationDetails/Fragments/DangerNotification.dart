import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/NotificationDetailsViewModel.dart';
import 'package:heimdall/Presentation/UI/NotificationDetails/Widgets/ImageWidget.dart';
import 'package:provider/provider.dart';

class DangerNotification extends StatelessWidget {
  DangerNotification({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationDetailsViewModel provider =
        Provider.of<NotificationDetailsViewModel>(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provider.notification.body,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20,),
              Text(
                "${provider.local!.lockName} : ${provider.card.name}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        provider.notification.urls.length == 1
            ? SizedBox(
                height: 230,
                child: ImageWidget(
                    onImagePress: provider.goToImagePreviewScreen,
                    image: provider.notification.urls.first,
                    tag: "1"))
            : CarouselSlider(
                options: CarouselOptions(
                    animateToClosest: false,
                    height: 220,
                    viewportFraction: 0.85,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height),
                items: provider.notification.urls
                    .map((e) =>ImageWidget(
                    onImagePress: provider.goToImagePreviewScreen,
                    image: e,
                    tag: provider.notification.urls.indexOf(e).toString()))
                    .toList(),
              ),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                provider.local!.notificationMessage,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20,),

              ElevatedButton(
                  onPressed: () {
                    provider.onLockCardPress(provider.card);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(provider.local!.lockDetails),
                  )),
              const SizedBox(height: 15,),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyTheme.red),
                  ),
                  onPressed: () {
                    provider.makeEmergencyCall();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(provider.local!.callEmergency , style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: MyTheme.white),),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
