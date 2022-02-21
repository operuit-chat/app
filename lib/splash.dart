import 'dart:async';

import 'package:flutter/material.dart';
import 'package:operuit_flutter/pin.dart';
import 'package:operuit_flutter/util/localdata.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
    IO.Socket socket = IO.io('http://localhost:8081/test');
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('message', (_) => print(_));
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/login.png'),
          ),
        ],
      ),
    );
  }
}
