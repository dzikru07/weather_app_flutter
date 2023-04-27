import 'package:flutter/material.dart';
import 'package:weather_app_flutter/pages/splash_screen/function/splash_screen_function.dart';
import 'package:weather_app_flutter/style/color.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SimpleFunc().GoToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logo/app_logo.png'))),
        ),
      ),
    );
  }
}
