import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/now_playing/now_playing_screen.dart';
import 'package:provider/provider.dart';

class PlayQueuePlaylist extends StatelessWidget {
  final String plId;

  PlayQueuePlaylist({this.plId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final playlists = Provider.of<Playlists>(context, listen: false).playlists;
    final pl = playlists.firstWhere((playlist) => playlist.playlistId == plId);
    final songs = Provider.of<Songs>(context, listen: false).songs;
    return Container(
      height: size.height,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          Song song = songs.firstWhere((sng) => sng.id == pl.songId[index]);
          return ListTile(
              title: Text(song.songName),
              subtitle: Text(song.artist),
              trailing: Icon(Icons.favorite_border),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
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
        },
        itemCount: pl.songId.length,
      ),
    );
  }
}