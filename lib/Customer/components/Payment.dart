import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nanoid/nanoid.dart';
import 'package:sahaayak_app/Shared/components/validation.dart';
import 'package:intl/intl.dart';

import '../../authentication_service.dart';
import '../../constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(this.displayName, this.requestMap, {Key? key}) : super(key: key);
  final Map<String, dynamic> requestMap;
  final String? displayName;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  static TextEditingController _cardNoController= TextEditingController();
  static TextEditingController _cvvController= TextEditingController();
  static TextEditingController _expiryController= TextEditingController();
  static TextEditingController _cardNameController= TextEditingController();
  String id = customAlphabet('acdefghijklmnopqrstuwxyz1234567890', 7);

  @override
  Widget build(BuildContext context) {
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
              height: MediaQuery.of(context).size.height/1.145,
              width: 320,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('Service ID : # $id',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: kFontFamily1,
                        fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: Text(
                      'Hi ${widget.displayName!.split(' ')[0]},',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: kFontFamily1,
                          fontWeight: FontWeight.bold),),
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
                        fontWeight: FontWeight.bold),),
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
                      return Validation.cvvValidation(
                          _cvvController.text);
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
                            child: Text("Pay  ${NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 0).format(widget.requestMap['price'])}",
                                style: TextStyle(
                                    fontSize: 20.0, fontFamily: kFontFamily1, color: Colors.white,fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            onPressed: () async {
                              try {
                                serviceSetup(id,widget.requestMap);
                                CollectionReference services = FirebaseFirestore.instance.collection('Services');
                                services.doc(id).set({
                                  'serviceId': id,
                                });
                                services.doc(id).update({
                                  'paid': true
                                });
                              } catch (Ex) {
                                print(Ex);
                              }
                            }),
                      ),
                    ),
                  ),
                ],),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
