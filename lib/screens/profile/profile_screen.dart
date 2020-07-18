import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/login/login_screen.dart';
import 'package:musicplayer/widgets/rounded_button.dart';
import 'package:musicplayer/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name, dropdownValue, dropdownValue2;

  File _filePicked;
  File _imagePicked;

  Map<String, IconData> _listHobbies = {
    'Reading': FontAwesomeIcons.book,
    'Travelling': FontAwesomeIcons.walking,
    'Collecting': FontAwesomeIcons.table,
    'Listen to Music': FontAwesomeIcons.headphones,
    'Playing Games': FontAwesomeIcons.gamepad,
    'Dancing': FontAwesomeIcons.signLanguage,
    'Photography': FontAwesomeIcons.camera,
  };

  void openExplorer() async {
    try {
      _filePicked = await FilePicker.getFile(type: FileType.image);
      setState(() {
        _imagePicked = _filePicked;
      });
      print(_imagePicked);
    } catch (error) {
      throw (error);
    }
  }

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

  Future<Widget> _showSheet(BuildContext context, Size size, Users users) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: size.height,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  height: 270,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        child: _imagePicked == null
                            ? Center(
                                child: Text("No Image Selected"),
                              )
                            : Image.file(
                                _imagePicked,
                                fit: BoxFit.cover,
                              ),
                      ),
                      FlatButton.icon(
                        onPressed: () => openExplorer(),
                        icon: Icon(FontAwesomeIcons.image),
                        label: Text("Pick an Image"),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFieldContainer(
                    margin: 10,
                    icon: Icons.tag_faces,
                    text: 'Your Name',
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Choose Your Hobbies"),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                          height: 3,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          'Reading',
                          'Travelling',
                          'Collecting',
                          'Listen to Music',
                          'Playing Games',
                          'Dancing',
                          'Photography',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Choose Your Hobbies"),
                      DropdownButton<String>(
                        value: dropdownValue2,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                          height: 3,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue2 = newValue;
                          });
                        },
                        items: <String>[
                          'Reading',
                          'Travelling',
                          'Collecting',
                          'Listen to Music',
                          'Playing Games',
                          'Dancing',
                          'Photography',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                RoundedButton(
                  color: Colors.blue,
                  text: "Update",
                  textColor: Colors.white,
                  press: () {
                    if (_imagePicked != null) {
                      if (name != null) {
                        if (dropdownValue != null && dropdownValue2 != null) {
                          users.updateProfile(
                            password: users.user[0].password,
                            updatedName: name,
                            updatedImgFile: _imagePicked.path.toString(),
                            updatedHobbies: [dropdownValue, dropdownValue2],
                          );
                          Navigator.of(context).pop();
                        } else {
                          _showDialog(context,
                              message: "Hobbies should not be empty");
                        }
                      } else {
                        _showDialog(context,
                            message: "Name should not be empty");
                      }
                    } else {
                      _showDialog(context, message: "Pick an Image");
                    }
                  },
                ),
                RoundedButton(
                  color: Colors.red,
                  text: "Cancel",
                  textColor: Colors.white,
                  press: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Consumer<Users>(
              builder: (BuildContext context, Users value, _) {
                return Image.file(
                  File(value.user[0].imgFile),
                  fit: BoxFit.cover,
                );
              },
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black45,
                child: SingleChildScrollView(
                  child: Column(
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
                              onPressed: () {
                                _showSheet(context, size, user);
                              },
                            ),
                            profileButton(
                              label: "Delete Your Profile",
                              icon: FontAwesomeIcons.userEdit,
                              onPressed: () async {
                                var connectionResult =
                                    await (Connectivity().checkConnectivity());
                                //Check if user is connected with internet
                                if (connectionResult ==
                                        ConnectivityResult.wifi ||
                                    connectionResult ==
                                        ConnectivityResult.mobile) {
                                  user.deleteUser(
                                    email: user.user[0].email,
                                    password: user.user[0].password,
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    LoginScreen.routeName,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
