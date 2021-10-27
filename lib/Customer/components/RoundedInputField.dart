import 'package:flutter/material.dart';
import 'package:sahaayak_app/constants.dart';

class RoundedInputField extends StatelessWidget {

  RoundedInputField({required this.obscureText,required this.labelText, required this.colorType });
  final bool obscureText;
  final String labelText;
  final Color colorType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(color: Colors.white,fontFamily: kFontFamily1),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(11.0)),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.blueGrey,
          fontFamily: kFontFamily1,
          fontWeight: FontWeight.bold,
        ),
        hoverColor: Colors.white,
      ),
    );
  }
}
