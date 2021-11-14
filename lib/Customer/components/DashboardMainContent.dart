import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:sahaayak_app/Customer/components/ActiveServiceCard.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../constants.dart';

final List<String> imgList = [
  'images/ad1.png',
  'images/ad2.png',
  'images/ad3.png',
  'images/ad4.png'
];

class DashboardMainContent extends StatefulWidget {
  @override
  State<DashboardMainContent> createState() => _DashboardMainContentState();
}

class _DashboardMainContentState extends State<DashboardMainContent> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: kBackgroundBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                  ),
                  items: imgList
                      .map((item) => Container(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                child: Image.asset(item,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
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
                height: 30.0,
              ),
              Center(child: ActiveServiceCard()),
            ],
          ),
        ),
      ),
    );
  }


}
