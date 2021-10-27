import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';
import '../../constants.dart';

class UpdatePage extends StatefulWidget {
  final String? uid;

  const UpdatePage(this.uid);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isChecked = false;
  bool _showPassword = false;
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
  TextEditingController _passwordController = TextEditingController();

  String? url;


  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : "No file Selected";
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc((widget.uid).toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            dynamic userDoc = snapshot.data!.data();

            _nameController.text = userDoc['displayName'];
            _nameController.value =  _nameController.value.copyWith(text: userDoc['displayName']);

            _emailController.text = userDoc['email'];
            _emailController.value =  _emailController.value.copyWith(text: userDoc['email']);

            _phoneController.text = userDoc['phoneNo'];
            _phoneController.value =  _phoneController.value.copyWith(text: userDoc['phoneNo']);

            _passwordController.text = userDoc['password'];
            _passwordController.value =  _passwordController.value.copyWith(text: userDoc['password']);


            typeDropDownVal = (userDoc['profileType']).toString();



            return SingleChildScrollView(
              child: Container(
                decoration: kBackgroundBoxDecoration,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      width: 300,
                      child: Column(
                        children: <Widget>[
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
                              backgroundImage: imageChanged ? pfpImg.image : Image.network('${userDoc['url']}').image,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: SizedBox(
                              width: 300,
                              child: DropdownButtonFormField(
                                iconEnabledColor: Colors.black,
                                dropdownColor: Colors.white,
                                onChanged: (newValue) {

                                    typeDropDownVal = newValue.toString();
                                    print(typeDropDownVal);
                                    setState(() {
                                    typeDropDownVal == 'Sahaayak'
                                        ? isSahaayak = true
                                        : isSahaayak = false;
                                   });
                                },
                                value: typeDropDownVal,
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
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(11.0)),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  labelText: 'Profile Type',
                                ),
                                items: <String>[
                                  'Sahaayak',
                                  'Customer',
                                ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: Colors.black,
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
                              width: 300,
                              child: TextFormField(
                                controller: _nameController,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: kFontFamily1,
                                    fontWeight: FontWeight.bold
                                ),
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
                                    fontWeight: FontWeight.bold
                                ),
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
                                controller: _emailController,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: kFontFamily1,
                                    fontWeight: FontWeight.bold
                                ),
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
                            height: 25,
                          ),
                          Center(
                            child: SizedBox(
                              width: 300,
                              child: StatefulBuilder(
                                builder: (context,StateSetter setState) {
                                  return TextFormField(
                                    controller: _passwordController,
                                    obscureText: !_showPassword,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: kFontFamily1,
                                        fontWeight: FontWeight.bold
                                    ),
                                    // keyboardType: TextInputType.visiblePassword,
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
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily: kFontFamily1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hoverColor: Colors.black,
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
                                            color: Colors.black,
                                          )),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          isSahaayak?ElevatedButton(
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
                            onPressed: () async {
                              FilePickerResult? idProof =
                                  await FilePicker.platform.pickFiles(
                                      allowedExtensions: ['pdf'],
                                      type: FileType.custom,
                                      allowMultiple: false);
                              print(
                                  '${idProof?.files.first.name},${idProof?.files.first.size}');
                              idProof!.files.first.size <= 10000000
                                  ? print("OK")
                                  : print("NOT OK");
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.attach_file),
                                Text('ID Proof')
                              ],
                            ),
                          ) : SizedBox(
                            height: 0,
                          ),
                          SizedBox(
                            height: 25,
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
                                CollectionReference users = FirebaseFirestore.instance.collection('Users');
                                print((widget.uid).toString());

                                // var imageFile = FirebaseStorage.instance.ref().child("files").child("abc.jpg");
                                // UploadTask task =  imageFile.putFile(file!);
                                // TaskSnapshot snapshot = await task ;

                                // url = await snapshot.ref.getDownloadURL();
                                // print(url);

                                    users
                                    .doc((widget.uid).toString())
                                    .update({
                                      'displayName':  _nameController.text,
                                      'email' : _emailController.text,
                                      'password' : _passwordController.text,
                                      'phoneNo' : _phoneController.text,
                                      'profileType' : typeDropDownVal,
                                       // 'url' : url
                                    })
                                    .then((value) => print("User Updated"))
                                    .catchError((error) => print("Failed to update user: $error"));
                              },
                              child: const Text('Update'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
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
