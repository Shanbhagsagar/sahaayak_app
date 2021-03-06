import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/Housekeeper/screens/ServiceRequest.dart';
import 'package:sahaayak_app/Housekeeper/components/DashboardMainContent.dart';

class Dashboard extends StatelessWidget {
  const Dashboard(this.huid,this.hname,this.phoneNumber,{Key? key}) : super(key: key);
  final String? huid;
  final String? hname;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Service Request'),
        backgroundColor: HexColor("#01274a"),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ServiceRequest(huid,hname,phoneNumber),
              fullscreenDialog: true,
            )),
        icon: Icon(Icons.bookmarks_outlined),
      ),
      body: DashboardMainContent(huid,phoneNumber),
    );
  }
}
