
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  ThemeSwitch({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return AnimatedToggleSwitch.size (
      current: themeProvider.getTheme(),
      values: [MyTheme.blackAndWhiteTheme, MyTheme.purpleAndWhiteTheme , MyTheme.darkPurpleTheme , MyTheme.darkBlueTheme],
      height: 50,
      iconBuilder: (value) {
        if(value == MyTheme.blackAndWhiteTheme){
          return SvgPicture.asset("assets/SVG/Theme1.svg" , height: 35,);
        }else if (value == MyTheme.purpleAndWhiteTheme){
          return SvgPicture.asset("assets/SVG/Theme4.svg" , height: 35,);
        }else if (value == MyTheme.darkPurpleTheme){
          return SvgPicture.asset("assets/SVG/Theme2.svg" , height: 35,);
        }else {
          return SvgPicture.asset("assets/SVG/Theme5.svg" , height: 35,);
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
        if(value == MyTheme.blackAndWhiteTheme){
          themeProvider.changeTheme(MyTheme.blackAndWhiteTheme);
        }else if (value == MyTheme.purpleAndWhiteTheme){
          themeProvider.changeTheme(MyTheme.purpleAndWhiteTheme);
        }else if (value == MyTheme.darkPurpleTheme){
          themeProvider.changeTheme(MyTheme.darkPurpleTheme);
        }else {
          themeProvider.changeTheme(MyTheme.darkBlueTheme);
        }
      },

    );
  }
}
