import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qatar_app/screens/login_page.dart';
import 'package:qatar_app/screens/registration_page.dart';
import 'package:qatar_app/screens/user/customerCare.dart';
import 'package:qatar_app/screens/user/requestForm.dart';
import 'package:qatar_app/screens/user/userScreen.dart';
import 'package:qatar_app/screens/welcome.dart';
import 'screens/user/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      routes: {
        '/': (context) => WelcomePage(),
        '/Registration': (context) => RegistrationPage(),
        '/Login': (context) => LoginPage(),
        '/User': (context) => UserScreen(
              child: HomePage(),
              title: "Home Page",
            ),
        '/RequestList': (context) => UserScreen(
              child: CustomerCare(),
              title: "Customer Care",
            ),
        '/AddRequest': (context) => UserScreen(
              child: AddRequest(),
              title: "Customer Care",
            ),
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return UserScreen(
      title: "Home Page",
      child: HomePage(),
    );
  }
}
