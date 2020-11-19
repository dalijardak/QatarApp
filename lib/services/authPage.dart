import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qatar_app/screens/user/home.dart';
import 'package:qatar_app/screens/welcome.dart';
import 'package:qatar_app/services/authentification.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return HomePage();
          else
            return WelcomePage();
        });
  }
}
