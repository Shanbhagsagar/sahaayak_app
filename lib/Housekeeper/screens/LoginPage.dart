import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:sahaayak_app/Customer/components/RoundedInputField.dart';
import 'package:sahaayak_app/Customer/components/LinkTextButton.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
            'images/signin_background.png',
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             fit: BoxFit.cover,
        ),
        Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 650,
                width: 550,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: HexColor("#01274a"), width: 1),
                  borderRadius: BorderRadius.circular(11),
                ),
                  color: HexColor("#01274a"),
                 child: Center(
                   child: Container(
                     width: 300,
                     child: Column(
                       children: <Widget>[
                         SizedBox(
                           height: 10,
                         ),
                        Image.asset(
                              'images/handshake2.png',
                             height: 180,
                            width: 200,
                          ),
                        Text(
                             'Sahaayak',
                             style: TextStyle(
                                 fontFamily: kFontFamily1,
                                color: Colors.white,
                               fontSize: 60,
                             ),
                         ),
                         SizedBox(
                           height: 25,
                         ),
                         RoundedInputField(obscureText: false,labelText: 'Email'),
                         SizedBox(
                           height: 30,
                         ),
                         RoundedInputField(obscureText: true,labelText: 'Password'),
                         SizedBox(
                           height: 10,
                         ),
                         Row(
                           children: <Widget>[
                             Checkbox(
                               hoverColor: null,
                               checkColor: Colors.white,
                               value: isChecked,
                               onChanged: (bool? value) {
                                 setState(() {
                                   isChecked = value!;
                                 });
                               },
                             ),
                             SizedBox(
                               width: 6,
                             ),
                             Text(
                                 'Remember Me',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontFamily: 'Ruluko',
                                   fontSize: 20,
                                 ),
                             )
                           ],
                         ),
                         SizedBox(
                           height: 25,
                         ),
                         ConstrainedBox(
                           constraints: BoxConstraints.tightFor(width: 250, height: 40),
                           child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               primary: HexColor("#007ef2"),
                               onPrimary: Colors.white,
                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                               textStyle: TextStyle(
                                 fontFamily: 'Ruluko',
                                 fontSize: 20
                               ),
                               shadowColor: Colors.black
                             ),
                             onPressed: () {},
                             child: const Text('Submit'),
                           ),
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             LinkTextButton(labelText: 'New User'),
                             LinkTextButton(labelText: 'Forgot Password?'),
                           ],
                         ),
                         SizedBox(
                           height: 10,
                         ),
                       ],
                     ),
                   ),
                 ),
                ),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black,
                      offset: const Offset(
                        3.5,
                        3.5,
                      ),
                      blurRadius: 2.0,
                      spreadRadius: 1.0
                    )
                  ]
                )
              ),
            ),
          ),
      ],
    );
  }
}


