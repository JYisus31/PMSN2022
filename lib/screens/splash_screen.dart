// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:practica1/screens/counter_screen.dart';
import 'package:practica1/screens/login_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/logo.jpg",
      text: "LOADING ...",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
        color: Colors.white,
      ),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
    );
  }
}
