
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {

    Timer(
        Duration(milliseconds: 3000,),()
    => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Home()),
            (route) => false) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff009688),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff009688),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            // color(0xffd8b6dd)
            Expanded(
                child: Image(
                  image: AssetImage('images/0.jpg'),
                )
            )
          ],
        ),
      ),
    );
  }
}