import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:sahaayak_app/Customer/components/RoundedInputField.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isChecked = false;
  bool isSahaayak = false;
  String? typeDropDownVal;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              width: 550,
              child: Center(
                child: Container(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      RoundedInputField(
                          obscureText: false, labelText: 'Name'),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedInputField(
                          obscureText: false, labelText: 'Phone'),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedInputField(
                          obscureText: false, labelText: 'Email'),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedInputField(
                          obscureText: true, labelText: 'Password'),
                      SizedBox(
                        height: 25,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: 250, height: 40),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: HexColor("#01274a"),
                              onPrimary: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12))),
                              textStyle: TextStyle(
                                  fontFamily: 'Ruluko', fontSize: 20),
                              shadowColor: Colors.black),
                          onPressed: () {},
                          child: const Text('Update'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
