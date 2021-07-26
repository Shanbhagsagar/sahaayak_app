import 'package:flutter/material.dart';
import 'package:sahaayak_app/constants.dart';


class LinkTextButton extends StatelessWidget {

  LinkTextButton({required this.labelText});
    final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
            fontSize: 20,
            fontFamily: kFontFamily1,
            decoration: TextDecoration.underline
        ),
        primary: Colors.white,
      ),
      onPressed: () {},
      child: Text(labelText),
    );
  }
}
