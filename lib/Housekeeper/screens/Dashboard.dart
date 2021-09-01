import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/Customer/screens/BookServices.dart';
import 'package:sahaayak_app/Customer/components/DashboardMainContent.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Find Sahaayak'),
        backgroundColor: HexColor("#01274a"),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => BookServices(),
              fullscreenDialog: true,
            )),
        icon: Icon(Icons.bookmark_add_outlined),
      ),
      body: DashboardMainContent(),
    );
  }
}
