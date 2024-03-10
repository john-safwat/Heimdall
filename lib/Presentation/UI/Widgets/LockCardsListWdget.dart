import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Presentation/UI/Widgets/LockCardWidget.dart';

class LockCardsListWidget extends StatelessWidget {
  List<LockCard> lockCardsList ;
  Function onLockCardPress;
  LockCardsListWidget({required this.lockCardsList ,
    required this.onLockCardPress ,super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: CarouselSlider(
        options: CarouselOptions(
            animateToClosest: false,
            height: 500,
            viewportFraction: 0.85,
            initialPage: 0,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            enlargeStrategy:
            CenterPageEnlargeStrategy.height),
        items: lockCardsList
            .map((e) => LockCardWidget(
            card: e,
            onCardClick: onLockCardPress))
            .toList(),
      ),
    );
  }
}
