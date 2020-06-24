import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayer/models/song.dart';

class Songs with ChangeNotifier {
  List<Song> _songs = [];

  List<Song> get songs {
    return [..._songs];
  }

  static FlutterAudioQuery audioQuery = FlutterAudioQuery();
  var rng = new Random();
  Future<void> getSongs() async {
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

//  final AssetsAudioPlayer aap = AssetsAudioPlayer();
//
//  void openSong({
//    String songFile,
//    String id,
//    String songName,
//    String artist,
//    String album,
//  }) {
//    aap.stop();
//    aap.open(
//      Audio.file(
//        songFile,
//        metas: Metas(
//          id: id,
//          title: songName,
//          artist: artist,
//          album: album,
//        ),
//      ),
//      showNotification: true,
//    );
//    aap.play();
//  }
//
//  void playSong() {
//    aap.play();
//  }
//
//  void pauseSong() {
//    aap.pause();
//  }
//
//  void nextSong(int index) {
//    if (index <= 0) {
//      return;
//    }
//    openSong(
//      songFile: _songs[index].songFile,
//      id: _songs[index].id,
//      songName: _songs[index].songName,
//      artist: _songs[index].artist,
//      album: _songs[index].album,
//    );
//  }
//
//  void prevSong(int index) {
//    if (index <= 0) {
//      return;
//    }
//    openSong(
//      songFile: _songs[index].songFile,
//      id: _songs[index].id,
//      songName: _songs[index].songName,
//      artist: _songs[index].artist,
//      album: _songs[index].album,
//    );
//  }

  static AudioPlayer audioPlayer = AudioPlayer();

  static void playSong(String fileName) {
    audioPlayer.play(fileName, isLocal: true);
  }

  static void pauseSong() {
    audioPlayer.pause();
  }

  static void resumeSong() {
    audioPlayer.resume();
  }
}
