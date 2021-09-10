import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahaayak_app/Customer/components/RoundedInputField.dart';

import '../../constants.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isChecked = false;
  bool isSahaayak = false;
  String? typeDropDownVal;
  Image pfpImg = Image.asset(
    'images/defimg.jpg',
    width: 160.0, height: 160.0, fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: kBackgroundBoxDecoration,
          height: MediaQuery.of(context).size.height-60,
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Container(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        child: CircleAvatar(
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
                                  icon: Icon(Icons.camera_enhance,size: 22,color: Colors.white,),
                                  onPressed: () async {
                                    FilePickerResult? pfp = await FilePicker.platform.pickFiles(type: FileType.image);
                                    pfp!=null?
                                    setState(() {
                                      pfpImg = kIsWeb?
                                      Image.memory(pfp.files.first.bytes!):
                                      Image.file(File(pfp.files.first.path));
                                    }) :print('Cancel');
                                  },
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
                      RoundedInputField(
                          obscureText: false, labelText: 'Name',colorType: Colors.black),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedInputField(
                          obscureText: false, labelText: 'Phone',colorType: Colors.black),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedInputField(
                          obscureText: false, labelText: 'Email',colorType: Colors.black),
                      SizedBox(
                        height: 25,
                      ),
                      RoundedInputField(
                          obscureText: true, labelText: 'Password',colorType: Colors.black),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top:15 ,bottom: 15),
                            primary: HexColor("#007ef2"),
                            onPrimary: Colors.white,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                            textStyle: TextStyle(
                                fontFamily: 'Ruluko',
                                fontSize: 20
                            ),
                            shadowColor: Colors.black
                        ),
                        onPressed: () async {
                          FilePickerResult? idProof = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf'],type: FileType.custom,allowMultiple: false);
                          print('${idProof?.files.first.name},${idProof?.files.first.size}');
                          idProof!.files.first.size<=10000000?print("OK"):print("NOT OK");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.attach_file),
                            Text('ID Proof')
                          ],
                        ),
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
                          onPressed: () {},
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
      ),
    );
  }
}
