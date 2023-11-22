import 'package:flutter/material.dart';
import 'package:heimdall/Core/Providers/ThemeProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {

  static const String routeName = "Login";

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: (){themeProvider.changeTheme(MyTheme.blackAndWhiteTheme);},
              child: const Text("Black And White"),
            ),
            ElevatedButton(
              onPressed: (){themeProvider.changeTheme(MyTheme.purpleAndWhiteTheme);},
              child: const Text("Purple And White"),
            ),
            ElevatedButton(
              onPressed: (){themeProvider.changeTheme(MyTheme.darkPurpleTheme);},
              child: const Text("Purple And Purple"),
            ),
            ElevatedButton(
              onPressed: (){themeProvider.changeTheme(MyTheme.darkBlueTheme);},
              child: const Text("Blue And Gold"),
            )
          ],
        ),
      ),
    );
  }
}
