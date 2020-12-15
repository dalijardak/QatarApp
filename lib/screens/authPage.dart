import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qatar_app/screens/admin/adminHome.dart';
import 'package:qatar_app/screens/superAdmin/superAdminHome.dart';
import 'package:qatar_app/screens/user/home.dart';
import 'package:qatar_app/screens/welcome.dart';
import 'package:qatar_app/services/authentification.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
                future: Auth().checkAdmin(),
                builder: (context, snapshot) {
                  if (snapshot.data == "superAdmin")
                    return SuperAdminScreen(); //to SuperAdminScreen
                  else if (snapshot.data == "admin")
                    return AdminScreen();
                  else if (snapshot.data == "user") return HomePage();
                  return Scaffold(
                    body: Container(),
                  );
                });
          } else
            return WelcomePage();
        });
  }
}
