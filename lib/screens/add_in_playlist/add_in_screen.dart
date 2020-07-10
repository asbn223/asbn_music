import 'dart:math';

import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/add_in_playlist/components/add_in_body.dart';
import 'package:provider/provider.dart';

class AddInScreen extends StatelessWidget {
  static String routeName = '/add_in_screen';
  TextEditingController _controller = TextEditingController();

  //Show dialog with textfield
  void _showDialog({BuildContext context, Function onPressed}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Name Your Playlist"),
            content: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Enter Playlist Name",
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Name is empty";
                }
                return null;
              },
              onSaved: (value) {
                _controller.text = value;
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: onPressed,
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final songId = ModalRoute.of(context).settings.arguments as String;
    final Playlists playlists = Provider.of<Playlists>(context);
    final user = Provider.of<Users>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add to Playlist"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showDialog(
                context: context,
                onPressed: () {
                  var rng = new Random();
                  int num = rng.nextInt(999999);
                  playlists.addInPlayList(
                    playlistId: 'playlist${num.toString()}',
                    playName: _controller.text,
                    songId: songId,
                    email: user[0].email,
                  );
                  Navigator.of(context).pop();
                },
              );
            },
          )
        ],
      ),
      body: AddToBody(),
    );
  }
}
