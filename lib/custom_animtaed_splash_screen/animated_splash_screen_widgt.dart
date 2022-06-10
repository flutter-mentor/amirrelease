import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../const/const.dart';

class CustomAnimatedSplash extends StatelessWidget {
  Widget nextWidget;
  CustomAnimatedSplash(this.nextWidget);
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: 'assets/spl.png',
        splashIconSize: 200,
        centered: true,
        backgroundColor: AppColors.primColor,
        nextScreen: nextWidget);
  }
}
