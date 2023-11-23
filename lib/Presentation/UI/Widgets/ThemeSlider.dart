import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemeSlider extends StatelessWidget {
  ThemeSlider({super.key});
  List<String> splashImagePath = [
    "assets/SVG/Splash.svg",
    "assets/SVG/Splash-1.svg",
    "assets/SVG/Splash-2.svg",
    "assets/SVG/Splash-3.svg"
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
          items: splashImagePath.map((e) => SvgPicture.asset(e)).toList(),
          options: CarouselOptions(
            initialPage: 3,
            height: double.infinity,
            aspectRatio: 0.05,
            viewportFraction: 0.55,
            enableInfiniteScroll: true,
          ),),
    );
  }
}
