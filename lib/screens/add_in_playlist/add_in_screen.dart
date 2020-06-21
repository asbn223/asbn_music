import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/screens/add_in_playlist/components/add_in_body.dart';
import 'package:provider/provider.dart';

class AddInScreen extends StatelessWidget {
  static String routeName = '/add_in_screen';
  TextEditingController _controller = TextEditingController();

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
    final Playlists playlists = Provider.of<Playlists>(context, listen: false);
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
                  final len = playlists.playlists.length;
                  playlists.addInPlayList('playlist${(len + 1).toString()}',
                      _controller.text, songId);
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
