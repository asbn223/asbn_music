import 'package:flutter/material.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/widgets/account_check.dart';
import 'package:musicplayer/widgets/rounded_button.dart';
import 'package:musicplayer/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatelessWidget {
  String email, password;

  void _showDialog(BuildContext context, {String message}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final users = Provider.of<Users>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            'assets/resources/login.png',
            height: size.height * 0.45,
          ),
          TextFieldContainer(
            margin: 10,
            icon: Icons.person,
            text: 'Your Email',
            onChanged: (value) {
              email = value;
            },
          ),
          TextFieldContainer(
            margin: 0,
            icon: Icons.lock,
            text: 'Password',
            obscureText: true,
            suffixIcon: Icons.remove_red_eye,
            onChanged: (value) {
              password = value;
            },
          ),
          RoundedButton(
            color: Color(0xFFFF7F50),
            text: 'Sign In',
            textColor: Color(0xFFFFFFFF),
            press: () {
              if (email != null) {
                if (email.contains('@')) {
                  if (password != null) {
                    if (password.length >= 8) {
                      users.login(
                        email: email.trim(),
                        password: password.trim(),
                      );
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    } else {
                      _showDialog(context,
                          message:
                              "Password needs to be more than 8 Characters");
                    }
                  } else {
                    _showDialog(context, message: "Password is empty");
                  }
                } else {
                  _showDialog(context, message: "Email is invalid");
                }
              } else {
                _showDialog(context, message: "Email is empty");
              }
            },
          ),
          AccountCheck(true),
        ],
      ),
    );
  }
}
