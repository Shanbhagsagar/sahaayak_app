import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:sahaayak_app/Customer/screens/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                  'images/handshake.png',
                  height: 300.0,
                  width:  300.0,
              ),
              Text(
                  "All housekeepers under one roof",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HexColor("#01274a"),
                  fontFamily: kFontFamily1,
                  fontSize: 30.0
                ),
              ),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
