import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final String name, userId, password, email;

  User({
    @required this.name,
    this.userId,
    @required this.password,
    @required this.email,
  });
}

class Users with ChangeNotifier {
  final firestoreInstance = Firestore.instance;

  List<User> _user = [];

  List<User> get user {
    return [..._user];
  }

  Future<void> createUser({String name, String password, String email}) async {
    try {
      final docRef = await firestoreInstance.collection('Users').add({
        'name': name,
        'password': password,
        'email': email,
      });
      User user = User(
        name: name,
        email: email,
        password: password,
        userId: docRef.documentID,
      );
      print(user.userId);
      _user.add(user);
    } catch (error) {
      throw (error);
    }
  }

//  Future<void> updateUser({String name, String, userName, String userId, String password, String email,}) async{
//    if(userId == null){
//      return;
//    }
//    try{
//      await firestoreInstance.collection('Users').document(userId).updateData({
//
//      });
//    }
//  }

}
