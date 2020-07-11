import 'package:flutter/material.dart';
import 'package:musicplayer/screens/register/user_details_screen.dart';
import 'package:musicplayer/widgets/account_check.dart';
import 'package:musicplayer/widgets/rounded_button.dart';
import 'package:musicplayer/widgets/textfield_container.dart';

class RegisterBody extends StatelessWidget {
  String name, email, password;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/resources/register.png',
              height: size.height * 0.45,
            ),
            TextFieldContainer(
              margin: 0,
              icon: Icons.tag_faces,
              text: 'Your Name',
              onChanged: (value) {
                name = value;
              },
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
              text: 'Next',
              textColor: Color(0xFFFFFFFF),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return UserDetailsScreen(
                        name: name,
                        email: email,
                        password: password,
                      );
                    },
                  ),
                );
              },
            ),
            AccountCheck(false),
          ],
        ),
      ),
    );
  }
}
