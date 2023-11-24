
import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:provider/provider.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {
  @override
  Widget build(BuildContext context) {
    var localProvider = Provider.of<LocalProvider>(context);
    return AnimatedToggleSwitch.size (
      current: localProvider.getLocal(),
      values: const ["en", "ar"],
      height: 40,
      fittingMode: FittingMode.preventHorizontalOverlapping,
      iconBuilder: (value) {
          if(value == "en"){
            return SvgPicture.asset("assets/SVG/En.svg" , height: 35,);
          }else{
            return SvgPicture.asset("assets/SVG/Ar.svg" , height: 35,);
          }
      },

      spacing: 10,
      style: ToggleStyle(
        backgroundColor: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        borderColor: Theme.of(context).primaryColor,
        indicatorBorder: Border.all(color: Colors.transparent),
        indicatorColor: Colors.transparent,
      ),

      onChanged: (value){
        localProvider.changeLocal(value);
      },

    );
  }
}
