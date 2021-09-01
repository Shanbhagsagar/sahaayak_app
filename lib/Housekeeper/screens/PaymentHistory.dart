import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/constants.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
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
                            leading: Icon(
                              Icons.arrow_circle_up_rounded,
                              color: Colors.green.shade900,
                            ),
                            title: Text(
                              "Transaction No: 1234565",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: kFontFamily1,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              "Rs 999",
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
                            "Status:   Paid",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: kFontFamily1,
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 80.0, top: 5.0, bottom: 20.0),
                          child: Text(
                            "Date:   12/03/2021",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
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
                            leading: Icon(
                              Icons.arrow_circle_down_rounded,
                              color: Colors.green.shade900,
                            ),
                            title: Text(
                              "Transaction No: 1234565",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: kFontFamily1,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              "Rs 999",
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
                            "Status:   Paid",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: kFontFamily1,
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 80.0, top: 5.0, bottom: 20.0),
                          child: Text(
                            "Date:   12/03/2021",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: kFontFamily1,
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
                            leading: Icon(
                              Icons.arrow_circle_down_rounded,
                              color: Colors.red.shade900,
                            ),
                            title: Text(
                              "Transaction No: 1234565",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: kFontFamily1,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              "Rs 999",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.red.shade900,
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
                            "Status:   Failed",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: kFontFamily1,
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0, top: 5.0),
                          child: Text(
                            "Date:   12/03/2021",
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
                                  child: Text("Pay".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: kFontFamily1,
                                          fontWeight: FontWeight.bold)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor("#f20000")),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(18.0),
                                                  bottomRight:
                                                      Radius.circular(18.0)),
                                              side: BorderSide(color: HexColor("#f20000"))))),
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
