import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/now_playing/now_playing_screen.dart';
import 'package:provider/provider.dart';

class AllSongsItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Song>(context, listen: false);
//    final songs = Provider.of<Songs>(context, listen: false);

    return ListTile(
        title: Text(song.songName),
        subtitle: Text(song.artist),
        trailing: Icon(Icons.favorite_border),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NowPlayingScreen(
              songId: song.id,
            );
          }));
          Songs.playSong(song.songFile);
          //Will show Notification with info of played song
          MediaNotification.showNotification(
            title: song.songName,
            author: song.artist,
            isPlaying: true,
          );
        });
  }
}
