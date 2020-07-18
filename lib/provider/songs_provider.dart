import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/provider/user_provider.dart';

class Songs with ChangeNotifier {
  List<Song> _songs = [];
  List<Song> _shuffledSongs = [];
  static List<String> favSong = [];
  final firestoreInstance = Firestore.instance;

  List<Song> get songs {
    return [..._songs];
  }

  List<Song> get shuffledSongs {
    return [..._shuffledSongs];
  }

  //Getting songs from the storage of phone
  static FlutterAudioQuery audioQuery = FlutterAudioQuery();
  var rng = new Random();

  //Fetches the data of the songs from the storage
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
  void shuffleSongs() {
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

  //Update Favourite for particular user
  Future<void> fav(String email, String songId) async {
    if (!favSong.contains(songId)) {
      favSong.add(songId);
    }

    await firestoreInstance
        .collection('Favourites')
        .document(email)
        .setData({'songId': favSong});
  }

  //Remove Favourite for particular user
  Future<void> refav(String email, String songId, bool isFav) async {
    if (!isFav && favSong.contains(songId)) {
      favSong.remove(songId);
    }

    await firestoreInstance
        .collection('Favourites')
        .document(email)
        .updateData({
      'songId': favSong,
    });
  }

  //Fetch the favourites set by the particular User
  Future<void> fetchFav() async {
    if (favSong.length > 0) {
      return;
    } else {
      String email = Users.users[0].email;
      try {
        final fav = await firestoreInstance
            .collection('Favourites')
            .document(email)
            .get();
        if (fav == null) {
          return;
        } else {
          List<dynamic> favS = fav.data['songId'];
          for (int i = 0; i < favS.length; i++) {
            favSong.add(favS[i]);
            int index =
                _songs.indexWhere((sng) => sng.id == favS[i].toString());
            Song song = Song(
              id: _songs[index].id,
              songName: _songs[index].songName,
              songFile: _songs[index].songFile,
              artist: _songs[index].artist,
              album: _songs[index].album,
              imgFile: _songs[index].imgFile,
              duration: _songs[index].duration,
              isFav: true,
            );
            _songs[index] = song;

            notifyListeners();
          }
        }
      } catch (error) {
        throw (error);
      }
    }
  }

  static void clearFav() {
    favSong.clear();
  }
}
