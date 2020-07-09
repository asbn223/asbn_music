import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  final String name, password, email;

  User({
    @required this.name,
    @required this.email,
    @required this.password,
  });
}

class Users with ChangeNotifier {
  final firestoreInstance = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String email;

  List<User> _user = [];

  List<User> get user {
    return [..._user];
  }

  String get userEmail {
    if (email.isEmpty) {
      return "";
    } else {
      return email;
    }
  }

  //Creating user for the music app
  Future<void> createUser({String name, String password, String email}) async {
    try {
      final registerUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestoreInstance.collection('Users').add({
        'name': name,
        'password': password,
        'email': email,
      });
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'email': email,
      });

      prefs.setString('userData', userData);
      User user = User(
        name: name,
        email: email,
        password: password,
      );
      _user.add(user);
    } catch (error) {
      throw (error);
    }
  }

  //Fetching user data from the database
  Future<void> fetchUserData() async {
    var userData;
    try {
      if (_user.isNotEmpty) {
        return;
      }
      final currentUser = await _auth.currentUser();
      if (currentUser == null) {
        final prefs = await SharedPreferences.getInstance();
        final extractedDate =
            json.decode(prefs.getString('userData')) as Map<String, Object>;
        email = extractedDate['email'];
        for (int i = 0; i < userData.documents.length; i++) {
          if (userData.documents[i]['email'] == email) {
            User user = User(
              name: userData.documents[i]['name'],
              email: userData.documents[i]['email'],
              password: userData.documents[i]['password'],
            );
            _user.add(user);
          }
        }
      } else {
        userData = await firestoreInstance.collection('Users').getDocuments();
        for (int i = 0; i < userData.documents.length; i++) {
          if (userData.documents[i]['email'] == currentUser.email) {
            User user = User(
              name: userData.documents[i]['name'],
              email: userData.documents[i]['email'],
              password: userData.documents[i]['password'],
            );
            _user.add(user);
          }
        }
      }
    } catch (error) {
      throw (error);
    }
  }

  //Login the user in the app
  Future<void> login({String email, String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'email': email,
    });

    prefs.setString('userData', userData);
  }

  //Login
  Future<void> logout() async {
    await _auth.signOut();
    //    Clear Data in Shared Preferencs value
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  //Auto-Log in
  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedDate =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    email = extractedDate['email'];
    notifyListeners();
    return true;
  }
}
