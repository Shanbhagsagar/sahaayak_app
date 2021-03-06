import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

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

Future<void> requestSetup(String id, Map<String, dynamic> requestData) async {
  CollectionReference req = FirebaseFirestore.instance.collection('Requests');
  req.doc(id).set(requestData);
}

Future<void> serviceSetup(String id, Map<String, dynamic> serviceData,DateTime date,String transID) async {
  CollectionReference seq = FirebaseFirestore.instance.collection('Services');
  serviceData.update('serviceId', (value) => id);
  serviceData.update('bookingDate', (value) => date);
  serviceData.update('paid', (value) => true);
  serviceData.addAll({'attendance':0,'attendanceDate':null,'transID':transID});
  seq.doc(id).set(serviceData);
}

Future<void> paymentSetup(String id, Map<String, dynamic> paymentData) async {
  CollectionReference peq = FirebaseFirestore.instance.collection('Payments');
  paymentData.update('paid', (value) => true);
  peq.doc(id).set(paymentData);
}

Future<bool> requestAcceptance(Map<String, dynamic> requestMap, String? huid,String? hname,String? phoneNumber) async {
  CollectionReference req = FirebaseFirestore.instance.collection('Requests');
  print('inside requestAccepted');
  print(requestMap);
  requestMap.update('accepted', (value) => true);
  requestMap.update('housekeeperID', (value) => huid);
  requestMap.addAll({'housekeeperName':hname,'housekeeperPhone':phoneNumber});
  req.doc(requestMap['requestID'].toString()).update(requestMap).onError((error, stackTrace) {
    print('requestAcceptance error');
    return false;
  });
  return true;

  // for (var doc in querySnapshots.docs) {
  //   await doc.reference.update({
  //     'single_field': 'newValue',
  //   });
  // }
}

Future<bool> sAttendance(String serviceId,int attendance, DateTime date) async {
  CollectionReference att = FirebaseFirestore.instance.collection('Services');
  print('inside requestAccepted');
  print('Inside authentication $attendance $date');
  att.doc(serviceId).update({'attendance': attendance,'attendanceDate':date})
     .then((value) => print("Attendance Updated"))
     .catchError((error) => print("Failed to update user: $error"));
  return true;
}

Future<bool> deleteService(String serviceId) async {
  CollectionReference att = FirebaseFirestore.instance.collection('Services');
  print('inside delete');
  att.doc(serviceId).delete()
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to delete user: $error"));
  return true;
}

Future<bool> payRefund(String transID,Map<String, dynamic> paymentMap) async {
  CollectionReference peq = FirebaseFirestore.instance.collection('Payments');
  print('inside payrefund');
  peq.doc(transID).set(paymentMap);
  return true;
}