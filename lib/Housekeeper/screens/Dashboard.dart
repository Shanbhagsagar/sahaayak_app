import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/Housekeeper/screens/BookServices.dart';
import 'package:sahaayak_app/Housekeeper/components/DashboardMainContent.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Service Request'),
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
