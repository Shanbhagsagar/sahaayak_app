import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi{
  static UploadTask? uploadFile(String destination, File file){
    final ref = FirebaseStorage.instance.ref(destination);

    return ref.putFile(file);
  }
  static UploadTask? uploadAdhaar(String destination1, File file1){
    final ref = FirebaseStorage.instance.ref(destination1);

    return ref.putFile(file1);
  }
}