import 'dart:async';

import 'package:flutter/material.dart';
import 'package:operuit_flutter/pin.dart';
import 'package:operuit_flutter/util/localdata.dart';

import 'login.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  Future<Widget> getStartScreen() async {
    bool exists = await LocalData.fileExists();
    if (exists) {
      return const MyPin();
    } else {
      return const MyLogin();
    }
  }

  route() async {
    var widget = await getStartScreen();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: new Color(0xffF5591F),
                gradient: LinearGradient(
                    colors: [(new Color(0x483d8b)), new Color(0xffF2861E)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          Center(
            child: Container(
              child: Image.asset('assets/login.png'),
            ),
          )
        ],
      ),
    );
  }
}