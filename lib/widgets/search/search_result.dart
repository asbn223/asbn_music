import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/play_one_song/play_one_screen.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatelessWidget {
  final String name;
  SearchResult(this.name);

  void _selectedSongs(BuildContext context, String id, String fileName, String songName, String author) {
    Songs.playSong(fileName);
    MediaNotification.showNotification(
      title: songName,
      author: author,
      isPlaying: true
    );
    Navigator.pushReplacementNamed(context, PlayOneScreen.routeName,
        arguments: id);
  }

  Widget _buildContainer(String imageUrl, String id) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: Colors.white)),
      ),
      height: 150,
      width: double.infinity,
      child: Hero(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        tag: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final songs = Provider.of<Songs>(context, listen: false).songs;
    final songName = songs.firstWhere((element) =>
        element.songName.toLowerCase().startsWith(name.toLowerCase()));
    return GestureDetector(
      onTap: () => _selectedSongs(context, songName.id, songName.songFile,songName.songName,songName.artist,),
      child: Stack(
        children: <Widget>[
          _buildContainer(
            songName.imgFile,
            songName.id,
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child: Container(
              color: Colors.black26,
              child: Text(
                songName.songName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
