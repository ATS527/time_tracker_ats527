import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:time_tracker/screens/home_page.dart';
import 'package:time_tracker/screens/sign_up_page.dart';
import '/services/auth.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final Auth _auth = new Auth();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return SignUpPage(auth: _auth);
          }
          return HomeScreen(auth: _auth);
        }
        return Scaffold(
          body: Center(
            child: Text("Loading!!!!"),
          ),
        );
      },
    );
  }
}
