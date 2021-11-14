import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String kFontFamily1 = 'Ruluko';

const BoxDecoration kBackgroundBoxDecoration = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("images/dash_back.png"),
    fit: BoxFit.cover,
  ),
);

const InputDecoration kInputEmailDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(11.0)),
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(11.0)),
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(11.0)),
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(11.0)),
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  labelText: 'Email',
  labelStyle: TextStyle(
    color: Colors.white,
    fontFamily: kFontFamily1,
    fontWeight: FontWeight.bold,
  ),
  hoverColor: Colors.white,
  prefixIcon: Icon(
      Icons.email,
    color: Colors.white,
  ),
);
