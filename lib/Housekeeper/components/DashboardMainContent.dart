import 'package:flutter/material.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:sahaayak_app/Housekeeper/components/ActiveServiceCard.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../constants.dart';

final List<String> imgList = [
  'images/ad1.png',
  'images/ad2.png',
  'images/ad3.png',
  'images/ad4.png'
];

class DashboardMainContent extends StatefulWidget {
  DashboardMainContent(this.huid,this.phoneNumber);
  final String? huid;
  final String? phoneNumber;

  @override
  State<DashboardMainContent> createState() => _DashboardMainContentState();
}

class _DashboardMainContentState extends State<DashboardMainContent> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height*1,
        decoration: kBackgroundBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "Active Services",
                  style: TextStyle(
                      fontFamily: kFontFamily1,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(height: MediaQuery.of(context).size.height.toDouble()/1.35,
                  child: ActiveServiceCard(widget.huid,widget.phoneNumber)),
            ],
          ),
        ),
      ),
    );
  }


}
