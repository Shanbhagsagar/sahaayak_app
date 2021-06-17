import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
                height: 700,
                width: 550,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue.shade900, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                  color: Colors.blue.shade900,
                 child: Column(
                   children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Image.asset(
                          'images/handshake2.png',
                         height: 200,
                        width: 200,
                      ),
                    ),
                    Text(
                         'Sahaayak',
                         style: TextStyle(
                             fontFamily: 'Ruluko',
                            color: Colors.white,
                           fontSize: 60,
                         ),
                     ),
                     
                   ],
                 ),
                ),
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0
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
