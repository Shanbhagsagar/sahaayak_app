import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/Shared/components/validation.dart';
import '../../constants.dart';

class UpdatePage extends StatefulWidget {
  final String? uid;

  const UpdatePage(this.uid);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isChecked = false;
  bool _customerHeight = false;
  bool isSahaayak = false;
  String? typeDropDownVal;
  bool imageChanged = false;
  Image pfpImg = Image.asset(
    'images/defimg.jpg',
    width: 160.0,
    height: 160.0,
    fit: BoxFit.cover,
  );

  File? file;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _profileTypeController = TextEditingController();
  TextEditingController _adhaarController = TextEditingController();

  static String? cityDropDownVal;
  static String? genderDropDownVal;
  String? url;
  final _formUpdateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final filename = file != null ? basename(file!.path) : "No file Selected";
    print(widget.uid);
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc((widget.uid).toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            dynamic userDoc = snapshot.data!.data();
          print(userDoc);
            _nameController.text = userDoc['displayName'];
            _nameController.value =
                _nameController.value.copyWith(text: userDoc['displayName']);

            _emailController.text = userDoc['email'];
            _emailController.value =
                _emailController.value.copyWith(text: userDoc['email']);

            _phoneController.text = userDoc['phoneNo'];
            _phoneController.value =
                _phoneController.value.copyWith(text: userDoc['phoneNo']);

            _profileTypeController.text = userDoc['profileType'];
            _profileTypeController.value = _profileTypeController.value
                .copyWith(text: userDoc['profileType']);

            if(userDoc['profileType'] == 'Sahaayak') {
              _adhaarController.text = userDoc['AdhaarID'];
              _adhaarController.value =
                  _adhaarController.value.copyWith(text: userDoc['AdhaarID']);

              genderDropDownVal = (userDoc['Gender']).toString();
              cityDropDownVal = (userDoc['City']).toString();
            }
            return SingleChildScrollView(
              child: Form(
                key: _formUpdateKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  decoration: kBackgroundBoxDecoration,
                   height: _profileTypeController.text == 'Customer'
                       ? MediaQuery.of(context).size.height/1.12 : null,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Container(
                        width: 300,
                        child: Column(
                          children: <Widget>[
                            _profileTypeController.text == 'Customer'
                                ? SizedBox(
                                    height: 40,
                                  )
                                : SizedBox(
                                    height: 10,
                                  ),
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 19.0,
                                    child: IconButton(
                                      splashRadius: 22,
                                      icon: Icon(
                                        Icons.camera_enhance,
                                        size: 22,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        imageChanged = true;
                                        FilePickerResult? pfp = await FilePicker
                                            .platform
                                            .pickFiles(type: FileType.image);
                                        pfp != null
                                            ? setState(() {
                                                pfpImg = kIsWeb
                                                    ? Image.memory(
                                                        pfp.files.first.bytes!)
                                                    : Image.file(File(
                                                        pfp.files.first.path));
                                              })
                                            : print('Cancel');
                                      },
                                      color: HexColor("#01274a"),
                                    ),
                                  ),
                                ),
                                radius: 63.0,
                                backgroundImage: imageChanged
                                    ? pfpImg.image
                                    : Image.network('${userDoc['url']}').image,
                                foregroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: _profileTypeController,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: kFontFamily1,
                                      color: Colors.grey.shade800),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    labelText: 'Profile Type',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: kFontFamily1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: _nameController,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: kFontFamily1,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: kFontFamily1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hoverColor: Colors.black,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(35),
                                    FilteringTextInputFormatter
                                        .singleLineFormatter
                                  ],
                                  validator: (value) {
                                    return Validation.nameValidation(
                                        _nameController.text);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: _phoneController,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: kFontFamily1,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    labelText: 'Phone No',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: kFontFamily1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hoverColor: Colors.black,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(35),
                                    FilteringTextInputFormatter
                                        .singleLineFormatter
                                  ],
                                  validator: (value) {
                                    return Validation.phoneValidation(
                                        _phoneController.text);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            _profileTypeController.text == 'Sahaayak'
                                ? Center(
                                    child: SizedBox(
                                      width: 300,
                                      child: DropdownButtonFormField(
                                        validator: (value) {
                                          return Validation.genderValidation(
                                              value);
                                        },
                                        iconEnabledColor: Colors.black,
                                        dropdownColor: Colors.white,
                                        value: genderDropDownVal,
                                        onChanged: (newValue) {
                                          //  setState(() {
                                          genderDropDownVal =
                                              newValue.toString();
                                          //  });
                                        },
                                        focusColor: Colors.black,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            fontFamily: kFontFamily1,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2.0),
                                          ),
                                          labelText: 'Gender',
                                        ),
                                        items: <String>[
                                          'Male',
                                          'Female',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor:
                                                    Colors.transparent,
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
                            _profileTypeController.text == 'Sahaayak'
                                ? SizedBox(
                                    height: 25,
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            _profileTypeController.text == 'Sahaayak'
                                ? Center(
                                    child: SizedBox(
                                      width: 300,
                                      child: DropdownButtonFormField(
                                        validator: (value) {
                                          return Validation.locCityValidation(
                                              value);
                                        },
                                        iconEnabledColor: Colors.black,
                                        dropdownColor: Colors.white,
                                        value: cityDropDownVal,
                                        onChanged: (newValue) {
                                          // setState(() {
                                          cityDropDownVal = newValue.toString();
                                          //  });
                                        },
                                        focusColor: Colors.black,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            fontFamily: kFontFamily1,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          labelText: 'City',
                                        ),
                                        items: <String>[
                                          'Dombivli',
                                          'Kalyan',
                                          'Thane'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor:
                                                    Colors.transparent,
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
                            _profileTypeController.text == 'Sahaayak'
                                ? SizedBox(
                                    height: 25,
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            _profileTypeController.text == 'Sahaayak'
                                ? Center(
                                    child: SizedBox(
                                      width: 300.0,
                                      child: TextFormField(
                                        controller: _adhaarController,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: kFontFamily1,
                                            fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2.0),
                                          ),
                                          labelText: 'Adhaar',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: kFontFamily1,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          hoverColor: Colors.white,
                                        ),
                                        inputFormatters: <TextInputFormatter>[
                                          LengthLimitingTextInputFormatter(35),
                                          FilteringTextInputFormatter
                                              .singleLineFormatter
                                        ],
                                        validator: (value) {
                                          return Validation.adhaarValidation(
                                              _adhaarController.text);
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            _profileTypeController.text == 'Sahaayak'
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
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: kFontFamily1,
                                      color: Colors.grey.shade800),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(11.0)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                    ),
                                    // focusColor: Colors.grey,
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: kFontFamily1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hoverColor: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 250, height: 40),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: HexColor("#01274a"),
                                    onPrimary: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    textStyle: TextStyle(
                                        fontFamily: 'Ruluko', fontSize: 20),
                                    shadowColor: Colors.black),
                                onPressed: () async {
                                  if (_formUpdateKey.currentState!.validate()) {
                                    CollectionReference users =
                                        FirebaseFirestore.instance
                                            .collection('Users');
                                    print((widget.uid).toString());

                                    // var imageFile = FirebaseStorage.instance.ref().child("files").child("abc.jpg");
                                    // UploadTask task =  imageFile.putFile(file!);
                                    // TaskSnapshot snapshot = await task ;

                                    // url = await snapshot.ref.getDownloadURL();
                                    // print(url);

                                    if (_profileTypeController.text ==
                                        "Sahaayak") {
                                      users
                                          .doc((widget.uid).toString())
                                          .update({
                                            'displayName': _nameController.text,
                                            'email': _emailController.text,
                                            'phoneNo': _phoneController.text,
                                            'Gender': genderDropDownVal,
                                            'City': cityDropDownVal,
                                            'AdhaarID': _adhaarController.text
                                          })
                                          .then(
                                              (value) => print("User Updated"))
                                          .catchError((error) => print(
                                              "Failed to update user: $error"));
                                    } else {
                                      users
                                          .doc((widget.uid).toString())
                                          .update({
                                            'displayName': _nameController.text,
                                            'email': _emailController.text,
                                            'phoneNo': _phoneController.text,
                                          })
                                          .then(
                                              (value) => print("User Updated"))
                                          .catchError((error) => print(
                                              "Failed to update user: $error"));
                                    }

                                    Fluttertoast.showToast(
                                        msg: "Updated Successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.yellow.shade900,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                child: const Text('Update'),
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
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
}
