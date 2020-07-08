import 'package:flutter/material.dart';
import 'package:musicplayer/screens/register/components/register_body.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = 'register_screen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RegisterBody(),
      ),
    );
  }
}
