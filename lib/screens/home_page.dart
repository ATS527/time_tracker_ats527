import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomeScreen extends StatelessWidget {
  final Auth auth;
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Home Screen"),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              auth.signOut();
            },
            child: Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
