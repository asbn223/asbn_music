import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  final String name, password, email, imgFile;
  final List<String> hobbies;

  User({
    @required this.name,
    @required this.email,
    @required this.password,
    this.imgFile,
    this.hobbies,
  });
}

class Users with ChangeNotifier {
  final firestoreInstance = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  static String email;

  List<User> users = [];

  List<User> get user {
    return [...users];
  }

  //Creating user for the music app
  Future<AuthResult> createUser(
      {String name,
      String password,
      String email,
      String imgFile,
      List<String> hobbies}) async {
    try {
      final registerUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (registerUser != null) {
        await firestoreInstance.collection('Users').add({
          'name': name,
          'password': password,
          'email': email,
          'imgFile': imgFile,
          'hobbies': hobbies,
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
          imgFile: imgFile,
          hobbies: hobbies,
        );
        users.add(user);
        return registerUser;
      } else {
        return null;
      }
    } catch (error) {
      throw (error);
    }
  }

  //Fetching user data from the database
  Future<void> fetchUserData() async {
    var userData;
    try {
      if (users.isNotEmpty) {
        return;
      }
      final currentUser = await _auth.currentUser();
      print(currentUser.email);
      if (currentUser == null) {
        final prefs = await SharedPreferences.getInstance();
        final extractedDate =
            json.decode(prefs.getString('userData')) as Map<String, Object>;
        email = extractedDate['email'];
        for (int i = 0; i < userData.documents.length; i++) {
          if (userData.documents[i]['email'] == email) {
            List<dynamic> val = userData.documents[i]['hobbies'];
            List<String> hobbies = [];
            for (int j = 0; j < val.length; j++) {
              hobbies.add(val[j]);
            }
            User user = User(
              name: userData.documents[i]['name'],
              email: userData.documents[i]['email'],
              password: userData.documents[i]['password'],
              imgFile: userData.documents[i]['imgFile'],
              hobbies: hobbies,
            );
            users.add(user);
          }
        }
      } else {
        userData = await firestoreInstance.collection('Users').getDocuments();
        for (int i = 0; i < userData.documents.length; i++) {
          if (userData.documents[i]['email'] == currentUser.email) {
            List<dynamic> val = userData.documents[i]['hobbies'];
            List<String> hobbies = [];
            for (int j = 0; j < val.length; j++) {
              hobbies.add(val[j]);
            }
            User user = User(
              name: userData.documents[i]['name'],
              email: userData.documents[i]['email'],
              password: userData.documents[i]['password'],
              imgFile: userData.documents[i]['imgFile'],
              hobbies: hobbies,
            );
            users.add(user);
          }
        }
      }
    } catch (error) {
      throw (error);
    }
  }

  //Login the user in the app
  Future<AuthResult> login({String email, String password}) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'email': email,
      });

      prefs.setString('userData', userData);
      return user;
    } else {
      return null;
    }
  }

  //Logout from the app
  Future<void> logout() async {
    await _auth.signOut();

    users.clear();
    Playlists.clearPlaylist();

    //Clear Data in Shared Preferencs value
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', null);
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

  Future<void> updateProfile({
    String password,
    String updatedName,
    List<String> updatedHobbies,
    String updatedImgFile,
  }) async {
    final userData = await firestoreInstance.collection('Users').getDocuments();
    userData.documents.forEach((element) {
      if (element['email'] == email) {
        int index = users.indexWhere((user) => user.email == email);
        User user = User(
          name: updatedName,
          email: email,
          password: password,
          imgFile: updatedImgFile,
          hobbies: updatedHobbies,
        );
        users[index] = user;
        firestoreInstance
            .collection('Users')
            .document(element.documentID)
            .updateData({
          'name': updatedName,
          'imgFile': updatedImgFile,
          'hobbies': updatedHobbies,
        });
      }
    });
    notifyListeners();
  }

  Future<void> deleteUser({String email, String password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user.user.delete();
      final userData =
          await firestoreInstance.collection('Users').getDocuments();
      userData.documents.forEach((element) {
        if (element['email'] == email) {
          print(element.documentID);
          int index = users.indexWhere((user) => user.email == email);
          users.removeAt(index);
          firestoreInstance
              .collection('Users')
              .document(element.documentID)
              .delete();
        }
        logout();
      });
    } catch (error) {
      throw (error);
    }
  }
}
