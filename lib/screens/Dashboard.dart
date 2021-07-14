import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
              Text("Hello World")

          ],
        ),
      ),
    );
  }
}
