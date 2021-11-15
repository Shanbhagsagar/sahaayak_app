import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahaayak_app/constants.dart';

class RoundedInputField extends StatefulWidget {

  RoundedInputField(
      {
      required this.labelText,
      required this.textcontroller,
      });

  final String labelText;
  final TextEditingController textcontroller;


  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {

  bool _autoEmailValidate = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: TextFormField(
          controller: widget.textcontroller,
          style: TextStyle(color: Colors.white, fontFamily: kFontFamily1),
            keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(11.0)),
              borderSide: const BorderSide(color: Colors. white, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(11.0)),
              borderSide: const BorderSide(color: Colors. white, width: 2.0),
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: Colors.white,
              fontFamily: kFontFamily1,
              fontWeight: FontWeight.bold,
            ),
            hoverColor: Colors.white,

          ),
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(35),
              FilteringTextInputFormatter.singleLineFormatter
            ],
         ),
      ),
    );
  }
}
