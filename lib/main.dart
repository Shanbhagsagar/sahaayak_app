import 'package:flutter/material.dart';
import 'package:sahaayak_app/screens/LoginPage.dart';
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
      title: 'Sahaayak',
      themeMode: ThemeMode.system,
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id:(context)=>LoginPage(),
      },
    );
  }
}
