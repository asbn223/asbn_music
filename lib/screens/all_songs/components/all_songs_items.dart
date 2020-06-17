import 'package:flutter/material.dart';
import 'package:musicplayer/helper/player_helper.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/screens/now_playing/now_playing_screen.dart';
import 'package:provider/provider.dart';

class AllSongsItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Song>(context, listen: false);
    return ListTile(
        title: Text(song.songName),
        subtitle: Text(song.artist),
        trailing: Icon(Icons.favorite_border),
        onTap: () {
          Navigator.of(context).pushNamed(
            NowPlayingScreen.routeName,
            arguments: song.id,
          );
          PlayerHelper.openSong(
            songFile: song.songFile,
            id: song.id,
            songName: song.songName,
            artist: song.artist,
            album: song.album,
          );
        });
  }
}
