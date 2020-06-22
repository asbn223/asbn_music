import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:musicplayer/models/playlist.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:provider/provider.dart';

class SongListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pl = Provider.of<Playlist>(context, listen: false);
    final songs = Provider.of<Songs>(context, listen: false).songs;
    return Container(
      height: size.height,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final song = songs.firstWhere((sng) => sng.id == pl.songId[index]);
          return ListTile(
            leading: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  song.imgFile,
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            title: Text(song.songName),
            onTap: () {
              Songs.playSong(song.songFile);
              MediaNotification.showNotification(
                title: song.songName,
                author: song.artist,
                isPlaying: true,
              );
            },
          );
        },
        itemCount: pl.songId.length,
      ),
    );
  }
}
