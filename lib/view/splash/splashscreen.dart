import 'dart:async';
import 'package:flutter/material.dart';
import 'package:holidaysmobile/constant/constant.dart';

import '../login/login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(50.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/Splash/place.png",
                    fit: BoxFit.cover,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  const Text(
                    'Holidays',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                ]),
          ),
        ));
  }
}
