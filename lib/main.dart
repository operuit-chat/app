import 'package:flutter/material.dart';
import 'package:operuit_flutter/welcome.dart';
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
          'register': (context) => const MyRegister(),
          'login': (context) => const MyLogin(),
          'splash': (context) => SplashScreen(),
          'pin': (context) => const MyPin(),
          'welcome': (context) => const WelcomeScreen(),
        },
      ),
    ),
  );
}
