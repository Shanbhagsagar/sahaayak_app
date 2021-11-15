import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sahaayak_app/Shared/components/validation.dart';
import 'package:intl/intl.dart';

import '../../authentication_service.dart';
import '../../constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(this.requestMap, {Key? key}) : super(key: key);
  final Map<String, dynamic> requestMap;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  static TextEditingController _cardNoController = TextEditingController();
  static TextEditingController _cvvController = TextEditingController();
  static TextEditingController _expiryController = TextEditingController();
  static TextEditingController _cardNameController = TextEditingController();
  String serviceID = customAlphabet('1234567890', 8);
  String transID = customAlphabet('1234567890', 12);

  @override
  Widget build(BuildContext context) {
    print('$serviceID + $transID');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#01274a"),
        centerTitle: true,
        title: Text('Make Payment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              width: 320,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Service ID : # $serviceID',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: kFontFamily1,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Center(
                      child: Text(
                        'Hi ${widget.requestMap['customerName']!.split(' ')[0]},',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22.0,
                            fontFamily: kFontFamily1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Please complete the payment process',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: kFontFamily1,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      maxLength: 16,
                      controller: _cardNoController,
                      validator: (value) {
                        return Validation.cardNoValidation(
                            _cardNoController.text);
                      },
                      style: TextStyle(
                        fontFamily: kFontFamily1,
                        color: HexColor("#01274a"),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Card No',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.disabled,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      maxLength: 3,
                      controller: _cvvController,
                      validator: (value) {
                        return Validation.cvvValidation(_cvvController.text);
                      },
                      style: TextStyle(
                        fontFamily: kFontFamily1,
                        color: HexColor("#01274a"),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'CCV',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      maxLength: 5,
                      controller: _expiryController,
                      validator: (value) {
                        return Validation.expiryValidation(
                            _expiryController.text);
                      },
                      style: TextStyle(
                        fontFamily: kFontFamily1,
                        color: HexColor("#01274a"),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Expiry',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.disabled,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      maxLength: 20,
                      controller: _cardNameController,
                      validator: (value) {
                        return Validation.cardNameValidation(
                            _cardNameController.text);
                      },
                      style: TextStyle(
                        fontFamily: kFontFamily1,
                        color: HexColor("#01274a"),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Name on Card',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      keyboardType: TextInputType.streetAddress,
                      autovalidateMode: AutovalidateMode.disabled,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightForFinite(
                              height: 40.0, width: double.maxFinite),
                          child: ElevatedButton(
                              child: Text(
                                  "Pay  ${NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 0).format(widget.requestMap['price'])}",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: kFontFamily1,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              onPressed: () async {
                                try {
                                  final result = await InternetAddress.lookup(
                                      'google.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    currentFocus.unfocus();

                                    var now = new DateTime.now();
                                    var formatter =
                                        new DateFormat('yyyy-MM-dd');
                                    String today = formatter.format(now);
                                    Map<String, dynamic> paymentMap = {
                                      "transID": transID,
                                      "serviceID": serviceID,
                                      "requestID":
                                          widget.requestMap['requestID'],
                                      "customerID":
                                          widget.requestMap['customerID'],
                                      "housekeeperID":
                                          widget.requestMap['housekeeperID'],
                                      "amount": widget.requestMap['price'],
                                      "bookingDate": today,
                                      "paid": null,
                                    };

                                    paymentSetup(transID, paymentMap);
                                    serviceSetup(
                                        serviceID, widget.requestMap, today);

                                    showModalBottomSheet(
                                        isDismissible: false,
                                        enableDrag: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          Timer(Duration(seconds: 2), (){
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                          return Container(
                                            height: 200,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                mainAxisSize:
                                                MainAxisSize
                                                    .min,
                                                children: <Widget>[
                                                  Center(
                                                      child: Icon(
                                                        Icons.check_circle_outline,
                                                        color: Colors.green.shade700,
                                                        size: 40,
                                                      )
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    15,
                                                  ),
                                                  const Text(
                                                    'Payment done successfully',
                                                    style:
                                                    TextStyle(
                                                      fontSize:
                                                      18.0,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      kFontFamily1,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    15,
                                                  ),
                                                  Center(
                                                    child: const Text(
                                                      'Redirecting....',
                                                      style:
                                                      TextStyle(
                                                        fontSize:
                                                        18.0,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        kFontFamily1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                } catch (Ex) {
                                  Fluttertoast.showToast(
                                      msg:
                                      "No connectivity found",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 4,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 10.0);
                                }
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
