import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required this.auth});
  final Auth auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Home Screen"),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await auth.signOut();
                            Navigator.of(context).pop();
                          },
                          child: Text("Logout"),
                        ),
                      ],
                    );
                  });
            },
            child: Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
