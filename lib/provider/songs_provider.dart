import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayer/models/song.dart';

class Songs with ChangeNotifier {
  List<Song> _songs = [];

  List<Song> get songs {
    return [..._songs];
  }

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  var rng = new Random();
  Future<void> getSongs() async {
    List<Song> _gotSongs = [];
    int id = 1;
    int imgId = 1;
    try {
      List<SongInfo> songs = await audioQuery.getSongs();
      await songs.forEach((song) {
        _gotSongs.add(
          Song(
            id: id.toString(),
            songName: song.title,
            artist: song.artist,
            album: song.album,
            songFile: song.filePath,
            imgFile: ('assets/resources/music${imgId.toString()}.jpg'),
          ),
        );
        id++;
        imgId = rng.nextInt(6) + 1;
      });
      _songs = _gotSongs;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
