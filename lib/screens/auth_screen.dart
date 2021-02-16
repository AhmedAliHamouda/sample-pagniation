import 'package:flutter/material.dart';
import 'package:flutter_test_app/screens/home_screen.dart';
import 'package:flutter_test_app/widgets/rounded_button_widget.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String loginEmail = '';
  String loginPassword = '';
  bool checkEmail = false;
  bool checkPass = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  loginEmail = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email.',
                  errorText: checkEmail ? 'Enter Valid Email' : null,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  loginPassword = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password.',
                  errorText: checkPass ? 'Enter Valid password' : null,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                color: Colors.indigo,
                onPressed: () {
                  if (loginEmail.isEmpty) {
                    setState(() {
                      checkEmail = true;
                    });
                  } else if (loginPassword.isEmpty) {
                    setState(() {
                      checkPass = true;
                    });
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
