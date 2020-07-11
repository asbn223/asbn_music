import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayer/models/song.dart';

class Songs with ChangeNotifier {
  List<Song> _songs = [];
  List<Song> _shuffledSongs = [];

  List<Song> get songs {
    return [..._songs];
  }

  List<Song> get shuffledSongs {
    return [..._shuffledSongs];
  }

  //Getting songs from the storage of phone
  static FlutterAudioQuery audioQuery = FlutterAudioQuery();
  var rng = new Random();
  Future<List<Song>> getSongs() async {
    List<Song> _gotSongs = [];
    int id = 1;
    int imgId = 1;
    try {
      List<SongInfo> songs = await audioQuery.getSongs();
      songs.forEach((song) {
        _gotSongs.add(
          Song(
            id: id.toString(),
            songName: song.title,
            artist: song.artist,
            album: song.album,
            songFile: song.filePath,
            duration: song.duration,
            imgFile: ('assets/resources/music${imgId.toString()}.jpg'),
          ),
        );
        id++;
        imgId = rng.nextInt(6) + 1;
      });
      _songs = _gotSongs;
      return _songs;
//      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  //Shuffle the songs
  Future<void> shuffleSongs() {
    var random = Random();
    _shuffledSongs.clear();

    for (int k = _songs.length - 1; k > 0; k--) {
      int n = random.nextInt(k + 1);
      _shuffledSongs.add(_songs[n]);
    }
  }

  //Getting AudioPlayer Instance
  static AudioPlayer audioPlayer = AudioPlayer();

  //Playing the songs
  static void playSong(String fileName) {
    audioPlayer.play(fileName, isLocal: true);
  }

  //Pausing currently playing song
  static void pauseSong() {
    audioPlayer.pause();
  }

  //Resuming currently paused song
  static void resumeSong() {
    audioPlayer.resume();
  }
}
