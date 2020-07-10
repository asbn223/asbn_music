import 'package:flutter/material.dart';
import 'package:musicplayer/screens/login/login_screen.dart';
import 'package:musicplayer/screens/register/register_screen.dart';

class AccountCheck extends StatelessWidget {
  final bool login;
  AccountCheck(this.login);

  //Check if the user is in login page or register page
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an account? " : 'Already have an account ?',
          style: TextStyle(fontSize: 12),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              login ? RegisterScreen.routeName : LoginScreen.routeName,
            );
          },
          child: Text(
            login ? 'Sign Up' : 'Sign In',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
