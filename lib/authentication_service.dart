
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


  Future<String?> signIn({required String email,required String password}) async {
    try{
     await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     return "Signed In";
    } on FirebaseAuthException catch(e){
       return e.message;
    }

  }
  Future<String?> signUp({required String email,required String password}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch(e){
      return e.message;
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