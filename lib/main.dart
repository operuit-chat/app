import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'splash.dart';
import 'pin.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'splash': (context) => SplashScreen(),
      'pin': (context) => MyPin(),
    },
  ));
}