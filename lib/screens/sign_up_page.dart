import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/screens/sign_in_with_email_page.dart';
import 'package:time_tracker/services/auth.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key, required this.auth}) : super(key: key);
  late Size size;
  final auth;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "Time Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        toolbarHeight: size.height * 0.08,
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: contents(context),
    );
  }

  Widget contents(BuildContext context) {
    return Container(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Sign In",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.04,
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          socialSignInButton(
              imageAsset: "google-logo.png",
              text: "Sign in with Google",
              textColor: Colors.black,
              buttonColor: Colors.white38,
              onButtonPress: () {
                try {
                  print("Sign in with Google");
                  auth.signInWithGoogle();
                } catch (e) {
                  print(
                    e.toString(),
                  );
                }
              }),
          SizedBox(
            height: size.height * 0.015,
          ),
          socialSignInButton(
              imageAsset: "facebook-logo.png",
              text: "Sign in with Facebook",
              textColor: Colors.white,
              buttonColor: Colors.blue[900]!,
              onButtonPress: () {
                print("Sign in with Facebook");
              }),
          SizedBox(
            height: size.height * 0.015,
          ),
          signInButton(
            text: "Sign in with Email",
            textColor: Colors.white,
            buttonColor: Colors.teal[700],
            onButtonPress: () => _signInWithEmail(context, auth),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            "or",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: size.height * 0.025,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          signInButton(
              text: "Sign in Anonymously",
              textColor: Colors.black,
              buttonColor: Colors.yellow[600]!,
              onButtonPress: () {
                try {
                  print("Sign in Anonymously");
                  Future<User?> user = auth.signInAnonymously();
                  print(user);
                } catch (e) {
                  print(
                    e.toString(),
                  );
                }
              }),
        ],
      ),
    );
  }

  void _signInWithEmail(BuildContext context, Auth auth) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return SignInWithEmailPage(auth: auth);
        }));
  }

  Widget socialSignInButton(
      {String? imageAsset,
      String? text,
      Color? textColor,
      Color? buttonColor,
      dynamic onButtonPress}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: size.width * 0.04),
          ),
        ),
        onPressed: onButtonPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/$imageAsset"),
            Text(
              text!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textColor,
                fontSize: size.height * 0.025,
              ),
            ),
            Opacity(
              opacity: 0,
              child: Image.asset("assets/images/$imageAsset"),
            ),
          ],
        ),
      ),
    );
  }

  Widget signInButton({
    String? text,
    Color? textColor,
    Color? buttonColor,
    dynamic onButtonPress,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: size.width * 0.04),
          ),
        ),
        onPressed: onButtonPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text!,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: textColor,
                fontSize: size.height * 0.025,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
