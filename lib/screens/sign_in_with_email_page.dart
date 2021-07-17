import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:time_tracker/services/email_form_validation.dart';

enum SignInType { login, register }

// ignore: must_be_immutable
class SignInWithEmailPage extends StatefulWidget with EmailFormValidator {
  SignInWithEmailPage({Key? key, required this.auth}) : super(key: key);

  final auth;

  EmailFormValidator formValidator = new EmailFormValidator();

  @override
  _SignInWithEmailPageState createState() => _SignInWithEmailPageState();
}

class _SignInWithEmailPageState extends State<SignInWithEmailPage> {
  SignInType _currentSignInType = SignInType.login;

  late Size size;

  late String primaryText;
  late String secondaryText;

  bool _isSubmitted = false;
  bool _isLoading = false;

  final TextEditingController _emailTextField = new TextEditingController();

  final TextEditingController _passwordTextField = new TextEditingController();

  void _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      print("signing in");
      _isSubmitted = true;
      if (_currentSignInType == SignInType.login) {
        await widget.auth.signInWithEmailAndPassword(
            _emailTextField.text, _passwordTextField.text);
      } else {
        await widget.auth.createUserWithEmailAndPassword(
            _emailTextField.text, _passwordTextField.text);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Sign in failed!"),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("OK"),
                ),
              ],
            );
          });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _changeLoginRegisterState() {
    setState(() {
      _isSubmitted = false;
      _currentSignInType = (_currentSignInType == SignInType.login)
          ? SignInType.register
          : SignInType.login;
    });
    _emailTextField.clear();
    _passwordTextField.clear();
  }

  @override
  Widget build(BuildContext context) {
    primaryText =
        (_currentSignInType == SignInType.login) ? "Log in" : "Register";
    secondaryText = (_currentSignInType == SignInType.login)
        ? "Need an account? Register"
        : "Have an account already? Login";

    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "Sign in",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        toolbarHeight: size.height * 0.09,
        leading: TextButton(
          onPressed: () {
            print("Go Back");
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: _signInWithEmailContents(),
    );
  }

  Widget _signInWithEmailContents() {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.03),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                  enabled: _isLoading == false ? true : false,
                  controller: _emailTextField,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "test@email.com",
                    labelText: "Email",
                    errorText: (widget.formValidator
                                    .isEmailValid(_emailTextField.text) ==
                                false &&
                            _isSubmitted)
                        ? "Email can't be Empty"
                        : null,
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (email) {
                    setState(() {});
                  }),
              TextField(
                enabled: _isLoading == false ? true : false,
                controller: _passwordTextField,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "min 4 characters long",
                  labelText: "Password",
                  errorText: (widget.formValidator
                                  .isPasswordValid(_passwordTextField.text) ==
                              false &&
                          _isSubmitted)
                      ? "Password can't be Empty"
                      : null,
                ),
                textInputAction: TextInputAction.done,
                onChanged: (password) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 18.0,
              ),
              ElevatedButton(
                onPressed:
                    (widget.formValidator.isEmailValid(_emailTextField.text) &&
                            widget.formValidator
                                .isPasswordValid(_passwordTextField.text) &&
                            !_isLoading)
                        ? _signIn
                        : null,
                child: Text(
                  primaryText,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(0, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
              ),
              TextButton(
                onPressed: !_isLoading ? _changeLoginRegisterState : null,
                child: Text(
                  secondaryText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(0, 50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
