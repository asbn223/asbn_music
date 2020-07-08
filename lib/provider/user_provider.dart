import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  List<User> _user = [];

  List<User> get user {
    return [..._user];
  }

  Future<void> createUser({String name, String password, String email}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestoreInstance.collection('Users').add({
        'name': name,
        'password': password,
        'email': email,
      });
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

  Future<void> fetchUserData() async {
    try {
      if (_user.isNotEmpty) {
        return;
      }
      final currentUser = await _auth.currentUser();
      final userData =
          await firestoreInstance.collection('Users').getDocuments();
      for (int i = 0; i < userData.documents.length; i++) {
        if (userData.documents[i]['email'] == currentUser.email) {
          print(userData.documents[i]['email']);
          User user = User(
            name: userData.documents[i]['name'],
            email: userData.documents[i]['email'],
            password: userData.documents[i]['password'],
          );
          _user.add(user);
        }
      }
    } catch (error) {
      throw (error);
    }
  }
}
