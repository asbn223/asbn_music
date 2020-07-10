import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/widgets/account_check.dart';
import 'package:musicplayer/widgets/rounded_button.dart';
import 'package:musicplayer/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

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
            press: () async {
              if (email != null) {
                if (email.contains('@')) {
                  if (password != null) {
                    if (password.length >= 8) {
                      try {
                        var connectionResult =
                            await (Connectivity().checkConnectivity());
                        if (connectionResult == ConnectivityResult.wifi ||
                            connectionResult == ConnectivityResult.mobile) {
                          AuthResult logUser = await users.login(
                            email: email.trim(),
                            password: password,
                          );
                          if (logUser != null) {
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
                          }
                        } else {
                          _showDialog(context,
                              message: "There is no internet connection.");
                        }
                      } catch (error) {
                        String errorMessage;
                        switch (error.code) {
                          case "ERROR_INVALID_EMAIL":
                            errorMessage = "Your email address is invalid.";
                            break;
                          case "ERROR_WRONG_PASSWORD":
                            errorMessage = "Your password is wrong.";
                            break;
                          case "ERROR_USER_NOT_FOUND":
                            errorMessage =
                                "User with this email doesn't exist.";
                            break;
                          case "ERROR_USER_DISABLED":
                            errorMessage =
                                "User with this email has been disabled.";
                            break;
                          case "ERROR_TOO_MANY_REQUESTS":
                            errorMessage =
                                "Too many requests. Try again later.";
                            break;
                          case "ERROR_OPERATION_NOT_ALLOWED":
                            errorMessage =
                                "Signing in with Email and Password is not enabled.";
                            break;
                          default:
                            errorMessage = "An undefined Error happened.";
                        }
                        _showDialog(context, message: errorMessage);
                      }
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
