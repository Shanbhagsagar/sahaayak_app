import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/Customer/components/MainMenu.dart';
import 'package:sahaayak_app/Shared/components/FirebaseApi.dart';
import 'package:sahaayak_app/constants.dart';
import 'package:sahaayak_app/Shared/components/RoundedInputField.dart';
import 'package:sahaayak_app/Firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  Image pfpImg = Image.asset(
    'images/defimg.jpg',
    width: 160.0,
    height: 160.0,
    fit: BoxFit.cover,
  );
  static String? typeDropDownVal;
  File? file;
  File? file1;
  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _phoneController = TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : "No file Selected";
    final filename1 =
        file1 != null ? basename(file1!.path) : "No file Selected";
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
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11.0)),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
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
                RoundedInputField(
                    labelText: 'Name', textcontroller: _nameController),
                SizedBox(
                  height: 25,
                ),
                RoundedInputField(
                    labelText: 'Phone', textcontroller: _phoneController),
                SizedBox(
                  height: 25,
                ),
                RoundedInputField(
                    labelText: 'Email', textcontroller: _emailController),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      style: TextStyle(
                          color: Colors.white, fontFamily: kFontFamily1),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11.0)),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11.0)),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
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
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                isSahaayak
                    ? Center(
                        child: SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                primary: HexColor("#007ef2"),
                                onPrimary: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                textStyle: TextStyle(
                                    fontFamily: 'Ruluko', fontSize: 20),
                                shadowColor: Colors.black),
                            onPressed: selectAdhaar,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.attach_file),
                                Text('ID Proof')
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 250, height: 40),
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
                    onPressed: () async {
                      try {
                        Map<String, dynamic> userData = {
                          "profileType": typeDropDownVal,
                          "displayName": _nameController.text,
                          "phoneNo": _phoneController.text,
                          "email": _emailController.text,
                          "password": _passwordController.text,
                          "Image Name": filename,
                          "isNewUser": true,
                        };
                        Map<String, dynamic> userData1 = {
                          "profileType": typeDropDownVal,
                          "displayName": _nameController.text,
                          "phoneNo": _phoneController.text,
                          "email": _emailController.text,
                          "password": _passwordController.text,
                          "Image Name": filename,
                          "Adhaar Name": filename1,
                          "isNewUser": true,
                        };
                        await Firebase.initializeApp();
                        UserCredential user = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                        userSetup(_nameController.text,
                            isSahaayak ? userData1 : userData);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainMenu()),
                        );
                        uploadFile();
                        isSahaayak ? uploadAdhaar() : print("Not Valid");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "weak-password") {
                          print("The password provided is too weak");
                        } else if (e.code == 'email-already-in-use') {
                          print("The account already exist for that email.");
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: const Text('Submit'),
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

  Future uploadFile() async {
    if (file == null) return;

    final filename = basename(file!.path);
    final destination = 'files/$filename';

    FirebaseApi.uploadFile(destination, file!);
  }

  Future selectAdhaar() async {
    FilePickerResult? idProof = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf'],
        type: FileType.custom,
        allowMultiple: false);
    print('${idProof?.files.first.name},${idProof?.files.first.size}');
    idProof!.files.first.size <= 10000000 ? print("OK") : print("NOT OK");

    // Upload Proof
    if (idProof == null) return;
    String path = idProof.files.single.path;
    print(path);

    setState(() => file1 = File(path));
  }

  Future uploadAdhaar() async {
    if (file1 == null) return;

    final filename1 = basename(file1!.path);
    final destination1 = 'files/$filename1';

    FirebaseApi.uploadAdhaar(destination1, file1!);
  }
}
