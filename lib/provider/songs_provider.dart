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

//  Future<void> fetchSong() async {
//    String audioPath = "";
//    List<Song> _gotSongs = [];
//    try {
//      audioPath = await StoragePath.audioPath;
//      var response = jsonDecode(audioPath);
//      for (int i = 0; i < 1; i++) {
////        print(response[i]['files'][0]);
//        int noOfSongs = response[i]['files'].length;
////        print(noOfSongs);
//        for (int j = 0; j < 1; j++) {
////          print(response[i]['files'][j]);
//          Map<String, dynamic> songs = response[i]['files'][j];
//          String displayName = songs['displayName'].toString().replaceAll(
//                songs['displayName'].toString().toLowerCase().contains(".mp3")
//                    ? ".mp3"
//                    : songs['displayName']
//                            .toString()
//                            .toLowerCase()
//                            .contains(".wav")
//                        ? ".wav"
//                        : ".m4a",
//                "",
//              );
//          _gotSongs.add(
//            Song(
//              songName: displayName,
//              album: songs['album'],
//              artist: songs['artist'],
//              file: File(songs['path']),
//            ),
//          );
//        }
//      }
//      _songs = _gotSongs;
//      notifyListeners();
//    } on PlatformException {
//      audioPath = 'Failed to get path';
//    }
//  }
}
