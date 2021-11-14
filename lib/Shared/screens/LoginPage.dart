import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/src/provider.dart';
import 'package:sahaayak_app/Shared/components/validation.dart';
import 'package:sahaayak_app/Shared/screens/Register.dart';
import 'package:sahaayak_app/authentication_service.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _showPassword = false;
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.white),
        child: Center(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/signin_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
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
                        fontSize: 50,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                            controller: _emailController,
                            style: TextStyle(
                                color: Colors.white, fontFamily: kFontFamily1),
                            keyboardType: TextInputType.emailAddress,
                            decoration: kInputEmailDecoration,
                            validator: (value) {
                              return Validation.emailValidation(value);
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            style: TextStyle(
                                color: Colors.white, fontFamily: kFontFamily1),
                            // keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
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
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: kFontFamily1,
                                fontWeight: FontWeight.bold,
                              ),
                              hoverColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.password_outlined,
                                color: Colors.white,
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  )),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(35),
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                            validator: (value) {
                              return Validation.passwordValidation(value);
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 250, height: 40),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: HexColor("#007ef2"),
                            onPrimary: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            textStyle:
                                TextStyle(fontFamily: 'Ruluko', fontSize: 20),
                            shadowColor: Colors.black),
                        onPressed: () {
                          context.read<AuthenticationService>().signIn(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: const Text(
                            'New User',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: kFontFamily1,
                                fontSize: 20.0),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (_emailController.text.length == 0) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please provide your Email ID for Forgot Password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: Colors.yellow.shade900,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: _emailController.text.trim())
                                  .then((value) => Fluttertoast.showToast(
                                      msg:
                                          "Reset your password mail has been sent on your registered Email ID.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.yellow.shade900,
                                      textColor: Colors.white,
                                      fontSize: 16.0));
                            }
                          },
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: kFontFamily1,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
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
