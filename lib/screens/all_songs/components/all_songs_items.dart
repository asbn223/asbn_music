import 'package:flutter/material.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/screens/now_playing/now_playing_screen.dart';
import 'package:provider/provider.dart';

class AllSongsItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Song>(context);
    return ListTile(
      title: Text(song.songName),
      subtitle: Text(song.artist),
      trailing: Icon(Icons.favorite_border),
      onTap: () => Navigator.of(context).pushNamed(
        NowPlayingScreen.routeName,
        arguments: song.id,
      ),
    );
  }
}
