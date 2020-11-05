import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:qatar_app/models/client.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  final dbRef = FirebaseDatabase.instance.reference().child("users");

  Future<String> signUp(Client client) async {
    // Created a second instance so it doesnt duplicate with current Auth
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);

    String result = "";

    try {
      await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
              email: client.email, password: client.password)
          .then((value) {
        dbRef.child(value.user.uid).set(client.toJson());
        value.user.updateProfile(displayName: client.fullName);
        result = "Success";
      });
      await FirebaseAuth.instanceFor(app: app)
          .currentUser
          .updateProfile(displayName: client.fullName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        result = "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        result = "The account already exists for that email";
      } else
        result = "Network error has occured";
    }
    await app.delete();

    return result;
  }

  Future<String> singIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => print(value),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return "Wrong password provided for that user";
      } else if (e.code == 'too-many-requests') {
        print('Too many requests');
        return "Too many login attempts";
      }
    }
    return "ok";
  }

  Future<void> checkUser() async {
    auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<dynamic> checkAdmin() async {
    final adminInfo = (await FirebaseDatabase.instance
        .reference()
        .child("admins")
        .child(Auth().auth.currentUser.uid)
        .once());
    return adminInfo.value;
  }

  Future<void> userInfo() {
    if (auth.currentUser != null) {
      print(auth.currentUser.uid);
      print(auth.currentUser.email);
      print(auth.currentUser.phoneNumber);
      print(auth.currentUser.displayName);
    }
    return null;
  }

  Future<void> signOut() {
    return auth.signOut();
  }
}
