import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = 'profile_screen';

  Map<String, IconData> _listHobbies = {
    'Reading': FontAwesomeIcons.book,
    'Travelling': FontAwesomeIcons.walking,
    'Collecting': FontAwesomeIcons.table,
    'Listen to Music': FontAwesomeIcons.headphones,
    'Playing Games': FontAwesomeIcons.gamepad,
    'Dancing': FontAwesomeIcons.signLanguage,
    'Photography': FontAwesomeIcons.camera,
  };

  Widget _buildRowContainer({IconData icon, String label}) {
    return Container(
      height: 75,
      width: 100,
      margin: EdgeInsets.all(0.0),
      padding: EdgeInsets.only(top: 8.0, left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoList(IconData icon, String test) {
    return Container(
      height: 50,
      child: ListTile(
        contentPadding: EdgeInsets.all(0.0),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          test,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget profileButton({String label, IconData icon, Function onPressed}) {
    return OutlineButton.icon(
      borderSide: BorderSide(
        width: 2,
        color: Color(0xFFFFFFFF),
        style: BorderStyle.solid,
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Color(0xFFFFFFFF),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.file(
              File(user.user[0].imgFile),
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height * 0.58,
                  width: double.infinity,
                  child: ListView(
                    children: <Widget>[
                      Text(
                        user.user[0].name,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Interest",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          _buildRowContainer(
                              icon: _listHobbies[user.user[0].hobbies[0]],
                              label: user.user[0].hobbies[0]),
                          _buildRowContainer(
                              icon: _listHobbies[user.user[0].hobbies[1]],
                              label: user.user[0].hobbies[1]),
                        ],
                      ),
                      _buildInfoList(
                          FontAwesomeIcons.mailBulk, user.user[0].email),
                      profileButton(
                        label: "Edit Your Profile",
                        icon: FontAwesomeIcons.userEdit,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
