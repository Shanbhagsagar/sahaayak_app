import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sahaayak_app/constants.dart';

class BookServices extends StatefulWidget {
  const BookServices({Key? key}) : super(key: key);

  @override
  _BookServicesState createState() => _BookServicesState();
}

class _BookServicesState extends State<BookServices> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#01274a"),
        centerTitle: true,
        title: Text('Book Services'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 320,
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
