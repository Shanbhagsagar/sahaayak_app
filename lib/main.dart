import 'package:flutter/material.dart';
import 'package:sahaayak_app/screens/Dashboard.dart';
import 'package:sahaayak_app/screens/LoginPage.dart';
import 'package:sahaayak_app/screens/SplashScreen.dart';
import 'components/MainMenu.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sahaayak',
      home: MainMenu(),
    );
  }
}
