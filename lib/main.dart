import 'package:dpkmobileflutter/pages/splashscreenPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Splash Screen',
    theme: ThemeData(fontFamily: 'Roboto'),
    home: const SplashscreenPage(),
  ));
}
