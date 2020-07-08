import 'package:flutter/material.dart';
import 'package:musicplayer/screens/login/components/login_body.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoginBody(),
      ),
    );
  }
}
