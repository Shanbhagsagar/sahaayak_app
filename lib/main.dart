import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sahaayak_app/authentication_service.dart';
import 'package:sahaayak_app/Customer/components/MainMenu.dart';
import 'package:sahaayak_app/Housekeeper/components/HMainMenu.dart';
import 'package:sahaayak_app/Shared/screens/LoginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    print(user?.uid);

    print(user);

    Stream<DocumentSnapshot<Map<String, dynamic>>> userDocStream =
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user?.uid)
            .snapshots();

    if (user != null) {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: userDocStream,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              dynamic userDocument = snapshot.data!.data();

              var profileType = userDocument['profileType'];
              print("Inside Stream Builder");
              print(userDocument);
              print(profileType);
              print("Email verification ${user.emailVerified}");

              if (profileType == 'Customer') {
                print(userDocument['displayName']);
                return new MainMenu(userDocument['displayName'], user.uid,user.phoneNumber);
              } else {
                return new HMainMenu(userDocument['displayName'], user.uid,user.phoneNumber);
              }
            } else {
              return Material(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          });
    }
    return LoginPage();
  }
}
