import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        if (_firebaseAuth.currentUser?.emailVerified == false) {
          Fluttertoast.showToast(
              msg:
                  "Your Email ID is not verified. Please complete the verification process",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.yellow.shade900,
              textColor: Colors.white,
              fontSize: 16.0);
          signOut();
        }
      }).catchError((error) {
        print(error.code);
        switch (error.code) {
          case "invalid-email":
          case "wrong-password":
          case "user-not-found":
            {
              Fluttertoast.showToast(
                  msg: "Wrong email address or password.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.yellow.shade900,
                  textColor: Colors.white,
                  fontSize: 16.0);
              break;
            }
          case "user-disabled":
          case "user-disabled":
            {
              Fluttertoast.showToast(
                  msg: "This account is disabled",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.yellow.shade900,
                  textColor: Colors.white,
                  fontSize: 16.0);
              break;
            }
        }
      });
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.yellow.shade900,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.yellow.shade900,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

Future<void> userSetup(
    String displayName, Map<String, dynamic> userData) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.doc(uid).set(userData);
}
