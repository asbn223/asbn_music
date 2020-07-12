import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  final String name, email, password;

//  static String routeName = '/user_details_screen';

  UserDetailsScreen({this.name, this.email, this.password});
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {


  String dropdownValue = 'Reading';
  String dropdownValue2;
  File _filePicked;
  File _imagePicked;

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

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
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

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                                child: Text("Image is not selected"),
                              )
                            : Image.file(
                                _imagePicked,
                                fit: BoxFit.cover,
                              ),
                      ),
                      FlatButton.icon(
//                        onPressed: () => _onImageButtonPressed(
//                          ImageSource.gallery,
//                          context: context,
//                        ),
                        onPressed: () => openExplorer(),
                        icon: Icon(FontAwesomeIcons.image),
                        label: Text("Pick an Image"),
                      )
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
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
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
                        style: TextStyle(color: Colors.black),
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
                  color: Color(0xFFFF7F50),
                  text: 'Sign Up',
                  textColor: Color(0xFFFFFFFF),
                  press: () async {
                    if (widget.name != null) {
                      if (!_isNumeric(widget.name)) {
                        if (widget.email != null) {
                          if (widget.email.contains('@')) {
                            if (widget.password != null) {
                              if (widget.password.length >= 8) {
                                try {
                                  var connectionResult = await (Connectivity()
                                      .checkConnectivity());
                                  //Check if user is connected with internet

                                  if (connectionResult ==
                                          ConnectivityResult.wifi ||
                                      connectionResult ==
                                          ConnectivityResult.mobile) {
                                    AuthResult regUser = await users.createUser(
                                      name: widget.name.trim(),
                                      email: widget.email.trim(),
                                      password: widget.password,
                                      imgFile: _imagePicked.path.toString(),
                                      hobbies: [dropdownValue, dropdownValue2],
                                    );
                                    if (regUser != null) {
                                      Navigator.pushReplacementNamed(
                                          context, HomeScreen.routeName);
                                    }
                                  } else {
                                    _showDialog(context,
                                        message:
                                            "There is no internet connection.");
                                  }
                                } catch (error) {
                                  String errorMessage;
                                  switch (error.code) {
                                    case "ERROR_INVALID_EMAIL":
                                      errorMessage =
                                          "Your email address is invalid.";
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
                                      errorMessage =
                                          "An undefined Error happened.";
                                  }
                                  _showDialog(context, message: errorMessage);
                                }
                              } else {
                                _showDialog(context,
                                    message:
                                        "Password needs to be more than 8 Characters");
                              }
                            } else {
                              _showDialog(context,
                                  message: "Password is empty");
                            }
                          } else {
                            _showDialog(context, message: "Email is invalid");
                          }
                        } else {
                          _showDialog(context, message: "Email is empty");
                        }
                      } else {
                        _showDialog(context,
                            message: "Name should not be in numeric format");
                      }
                    } else {
                      _showDialog(context, message: "Name is empty");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
