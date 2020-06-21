import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatelessWidget {
  static String routeName = 'playlist_screen';
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlists>(context).playlists;
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(playlist[0].songId[0]),
            Text(playlist[0].songId[1]),
            Text(playlist[0].songId[2]),
          ],
        ),
      ),
    );
  }
}
