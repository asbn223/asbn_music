import 'package:flutter/material.dart';
import 'package:musicplayer/widgets/account_check.dart';
import 'package:musicplayer/widgets/rounded_button.dart';
import 'package:musicplayer/widgets/textfield_container.dart';

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            onChanged: (value) {},
          ),
          TextFieldContainer(
            margin: 0,
            icon: Icons.lock,
            text: 'Password',
            obscureText: true,
            suffixIcon: Icons.remove_red_eye,
            onChanged: (value) {},
          ),
          RoundedButton(
            color: Color(0xFFFF7F50),
            text: 'Sign In',
            textColor: Color(0xFFFFFFFF),
            press: () => null,
          ),
          AccountCheck(true),
        ],
      ),
    );
  }
}
