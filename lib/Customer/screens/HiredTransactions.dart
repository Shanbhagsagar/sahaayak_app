import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:sahaayak_app/Customer/components/PhotoHero.dart';

class HiredTransactions extends StatefulWidget {
  const HiredTransactions({Key? key}) : super(key: key);

  @override
  _HiredTransactionsState createState() => _HiredTransactionsState();
}

class _HiredTransactionsState extends State<HiredTransactions> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: kBackgroundBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                  child: Container(
                width: 500,
                padding: new EdgeInsets.all(5.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: ListTile(
                            leading: PhotoHero(
                              photo: 'images/handshake.png',
                              width: 50.0,
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                  return Scaffold(
                                    body: Container(
                                      // The blue background emphasizes that it's a new route.
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.topLeft,
                                      child: Center(
                                        child: PhotoHero(
                                          photo: 'images/handshake.png',
                                          width: 300.0,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                              },
                            ),
                            title: Text(
                              "Service No: 1234565",
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: kFontFamily1,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              "Active",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.green.shade900,
                                  fontFamily: kFontFamily1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0),
                          child: Text(
                            "Sahayaak Name: Sagar Shanbhag",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0, top: 5.0),
                          child: Text(
                            "Sahayaak ID:   12345",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0, top: 5.0),
                          child: Text(
                            "City:   Dombivli",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0, top: 5.0),
                          child: Text(
                            "Gender:   Male",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: Text(
                              "Your service expires in 30 days",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.red.shade900,
                                  fontFamily: kFontFamily1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 130, height: 40),
                              child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.call,
                                        size: 30.0,
                                      ),
                                      Text("Call".toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: kFontFamily1)),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor("#01274a")),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color:
                                                      HexColor("#01274a"))))),
                                  onPressed: () => null),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightForFinite(
                                  height: 40.0, width: double.maxFinite),
                              child: ElevatedButton(
                                  child: Text("Rehire".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: kFontFamily1)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor("#01274a")),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(18.0),
                                                  bottomRight:
                                                      Radius.circular(18.0)),
                                              side: BorderSide(color: HexColor("#01274a"))))),
                                  onPressed: () => null),
                            ),
                          ),
                        ),
                      ],
                    )),
              )),
              Center(
                  child: Container(
                width: 500,
                padding: new EdgeInsets.all(5.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: ListTile(
                            leading: PhotoHero(
                              photo: 'images/handshake.png',
                              width: 50.0,
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                  return Scaffold(
                                    body: Container(
                                      // The blue background emphasizes that it's a new route.
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.all(16.0),
                                      alignment: Alignment.topLeft,
                                      child: Center(
                                        child: PhotoHero(
                                          photo: 'images/handshake.png',
                                          width: 300.0,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                              },
                            ),
                            title: Text(
                              "Service No: 1234565",
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: kFontFamily1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0),
                          child: Text(
                            "Sahayaak Name: Sagar Shanbhag",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0, top: 5.0),
                          child: Text(
                            "Sahayaak ID:   12345",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0, top: 5.0),
                          child: Text(
                            "City:   Dombivli",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0, top: 5.0),
                          child: Text(
                            "Gender:   Male",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
                            ),
                          ),
                        ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightForFinite(
                                  height: 40.0, width: double.maxFinite),
                              child: ElevatedButton(
                                  child: Text("Rehire".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: kFontFamily1)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor("#01274a")),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(18.0),
                                                  bottomRight:
                                                      Radius.circular(18.0)),
                                              side: BorderSide(color: HexColor("#01274a"))))),
                                  onPressed: () => null),
                            ),
                          ),
                        ),
                      ],
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
