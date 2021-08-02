import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
        title: Center(
          child: Text('Book Services'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
