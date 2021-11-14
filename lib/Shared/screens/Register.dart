import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/src/provider.dart';
import 'package:sahaayak_app/Shared/components/validation.dart';
import 'package:sahaayak_app/Shared/screens/LoginPage.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:sahaayak_app/Shared/components/RoundedInputField.dart';
import 'package:sahaayak_app/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isChecked = false;
  bool isSahaayak = false;
  bool _showPassword = false;
  bool _verify = false;
  Image pfpImg = Image.asset(
    'images/defimg.jpg',
    width: 160.0,
    height: 160.0,
    fit: BoxFit.cover,
  );
  static String? typeDropDownVal;
  static String? cityDropDownVal;
  static String? genderDropDownVal;
  File? file;
  File? file1;
  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _phoneController = TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();
  static final TextEditingController _adhaarController =
      TextEditingController();
  String? url;

  final _formRegisterKey = GlobalKey<FormState>();

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _phoneController.dispose();
  //   _passwordController.dispose();
  //   _adhaarController.dispose();
  //   _nameController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : "No file Selected";
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/signin_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formRegisterKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    'Register',
                    style: TextStyle(
                      fontFamily: kFontFamily1,
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    child: CircleAvatar(
                      radius: 65.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 19.0,
                            child: IconButton(
                              splashRadius: 22,
                              icon: Icon(
                                Icons.camera_enhance,
                                size: 22,
                              ),
                              onPressed: selectFile,
                              color: HexColor("#01274a"),
                            ),
                          ),
                        ),
                        radius: 63.0,
                        backgroundImage: pfpImg.image,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: DropdownButtonFormField(
                        validator: (value) {
                          return Validation.profileTypeValidation(value);
                        },
                        iconEnabledColor: Colors.white,
                        dropdownColor: Colors.lightBlue,
                        value: typeDropDownVal,
                        onChanged: (newValue) {
                          setState(() {
                            typeDropDownVal = newValue.toString();
                            typeDropDownVal == 'Sahaayak'
                                ? isSahaayak = true
                                : isSahaayak = false;
                          });
                        },
                        focusColor: Colors.black,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontFamily: kFontFamily1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
                          labelText: 'Profile Type',
                        ),
                        items: <String>[
                          'Sahaayak',
                          'Customer',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.transparent,
                                fontFamily: kFontFamily1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        controller: _nameController,
                        style: TextStyle(color: Colors.white, fontFamily: kFontFamily1),
                        keyboardType: TextInputType.name,
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
                          ),   prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                          labelText: 'Name',
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
                        validator: (value) {
                          return Validation.nameValidation(value);
                        },
                      ),
                    ),
                  ),
                  isSahaayak
                      ? SizedBox(
                          height: 25,
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  isSahaayak
                      ? Center(
                          child: SizedBox(
                            width: 300,
                            child: DropdownButtonFormField(
                              validator: (value) {
                                return Validation.genderValidation(value);
                              },
                              iconEnabledColor: Colors.white,
                              dropdownColor: Colors.lightBlue,
                              value: genderDropDownVal,
                              onChanged: (newValue) {
                                setState(() {
                                  genderDropDownVal = newValue.toString();
                                });
                              },
                              focusColor: Colors.black,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontFamily: kFontFamily1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                labelText: 'Gender',
                              ),
                              items: <String>[
                                'Male',
                                'Female',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.transparent,
                                      fontFamily: kFontFamily1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  isSahaayak
                      ? SizedBox(
                          height: 25,
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  isSahaayak
                      ? Center(
                          child: SizedBox(
                            width: 300,
                            child: DropdownButtonFormField(
                              validator: (value) {
                                return Validation.locCityValidation(value);
                              },
                              iconEnabledColor: Colors.white,
                              dropdownColor: Colors.lightBlue,
                              value: cityDropDownVal,
                              onChanged: (newValue) {
                                setState(() {
                                  cityDropDownVal = newValue.toString();
                                });
                              },
                              focusColor: Colors.black,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontFamily: kFontFamily1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                labelText: 'City',
                              ),
                              items: <String>['Dombivli', 'Kalyan', 'Thane']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.transparent,
                                      fontFamily: kFontFamily1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(
                    height: 25,
                  ),
              Center(
                child: SizedBox(
                  width: 300.0,
                  child: TextFormField(
                    controller: _phoneController,
                    style: TextStyle(color: Colors.white, fontFamily: kFontFamily1),
                    keyboardType: TextInputType.phone,
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
                      ),   prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                      labelText: 'Phone No.',
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
                    validator: (value) {
                      return Validation.phoneValidation(value);
                    },
                  ),
                ),
              ),
                  SizedBox(
                    height: 25,
                  ),
                  isSahaayak
                      ?       Center(
                    child: SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        controller: _adhaarController,
                        style: TextStyle(color: Colors.white, fontFamily: kFontFamily1),
                        keyboardType: TextInputType.phone,
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
                          ),   prefixIcon: Icon(
                          Icons.perm_identity,
                          color: Colors.white,
                        ),
                          labelText: 'Adhaar',
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
                        validator: (value) {
                          return Validation.adhaarValidation(value);
                        },
                      ),
                    ),
                  )
                      : SizedBox(
                          height: 0,
                        ),
                  isSahaayak
                      ? SizedBox(
                          height: 25,
                        )
                      : SizedBox(
                          height: 0,
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
                    height: 25,
                  ),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        style: TextStyle(
                            color: Colors.white, fontFamily: kFontFamily1),
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
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Colors.white,
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: kFontFamily1,
                            fontWeight: FontWeight.bold,
                          ),
                          hoverColor: Colors.white,
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
                        // inputFormatters: <TextInputFormatter>[
                        //   LengthLimitingTextInputFormatter(35),
                        //   FilteringTextInputFormatter.singleLineFormatter
                        // ],
                        validator: (value) {
                          return Validation.passwordValidation(value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 250, height: 40),
                    child: _verify == false ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: HexColor("#007ef2"),
                          onPrimary: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          textStyle:
                              TextStyle(fontFamily: 'Ruluko', fontSize: 20),
                          shadowColor: Colors.black),
                      onPressed: () async {
                        setState(() {
                          _verify = true;
                        });
                        try {
                          UserCredential user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim());

                          user.user?.sendEmailVerification();

                          var imageFile = FirebaseStorage.instance
                              .ref()
                              .child("files")
                              .child("abc.jpg");
                          UploadTask task = imageFile.putFile(file!);
                          TaskSnapshot snapshot = await task;

                          url = await snapshot.ref.getDownloadURL();
                          print(url);

                          Map<String, dynamic> userData = {
                            "profileType": typeDropDownVal,
                            "displayName": _nameController.text,
                            "phoneNo": _phoneController.text,
                            "email": _emailController.text,
                            "password": _passwordController.text,
                            "ImageName": filename,
                            "url": url
                          };

                          Map<String, dynamic> userData1 = {
                            "profileType": typeDropDownVal,
                            "displayName": _nameController.text,
                            "phoneNo": _phoneController.text,
                            "email": _emailController.text,
                            "password": _passwordController.text,
                            "ImageName": filename,
                            "url": url,
                            "AdhaarID": _adhaarController.text,
                            "City": cityDropDownVal,
                            "Gender": genderDropDownVal,
                          };

                          userSetup(_nameController.text,
                              isSahaayak ? userData1 : userData);
                          // uploadFile();

                          final snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.yellow.shade900,

                            content: Text(
                                'Email verification has been sent on your given Email-Id',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 13.0,
                                   fontWeight: FontWeight.bold,
                                ),
                            ),
                            duration: const Duration(minutes: 2),
                            action: SnackBarAction(
                              label: 'Login',
                              textColor: Colors.white,
                              onPressed: () {
                                context.read<AuthenticationService>().signOut();
                                _nameController.text = '';
                                _phoneController.text = '';
                                _emailController.text = '';
                                _passwordController.text = '';
                                _adhaarController.text = '';
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        } on FirebaseAuthException catch (e) {
                          if (e.code == "weak-password") {
                            print("The password provided is too weak");
                            AlertDialog(
                              title: Row(
                                children: [
                                 Icon(
                                  Icons.add_alert_rounded,
                                  color: Colors.yellowAccent.shade700,
                                   size: 15.0,
                                 ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text('Alert')
                                ],
                              ),
                              content: Text('The password provided is too weak'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          } else if (e.code == 'email-already-in-use') {
                            print("The account already exist for that email.");
                            AlertDialog(
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.add_alert_rounded,
                                    color: Colors.yellowAccent.shade700,
                                    size: 15.0,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text('Alert')
                                ],
                              ),
                              content: Text('The account already exist for that email.Please use another Email-Id'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: const Text('Submit'),
                    )
                    :Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black12,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    // Display Image
    setState(() {
      pfpImg = kIsWeb
          ? Image.memory(result!.files.first.bytes!)
          : Image.file(File(result!.files.first.path));
    });

    // Upload Image
    if (result == null) return;
    String path = result.files.single.path;
    print(path);

    setState(() => file = File(path));
  }

// Future uploadFile() async {
//   if (file == null) return;
//
//   final filename = basename(file!.path);
//   final destination = 'files/$filename';
//
//   print(destination);
//
//   FirebaseApi.uploadFile(destination, file!);
//   print(FirebaseApi.uploadFile(destination, file!));
//
//   // var imageFile = FirebaseStorage.instance.ref().child("files").child("/.jpg");
//   // UploadTask task =  imageFile.putFile(file!);
//   // TaskSnapshot snapshot = await task ;
//   //
//   // url = await snapshot.ref.getDownloadURL();
//
//
//
// }
}
