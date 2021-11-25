import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'login.dart';
import 'register.dart';
import 'splash.dart';
import 'pin.dart';

void main() {
  runApp(
    OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          'register': (context) => MyRegister(),
          'login': (context) => MyLogin(),
          'splash': (context) => SplashScreen(),
          'pin': (context) => MyPin(),
        },
      ),
    ),
  );
}
