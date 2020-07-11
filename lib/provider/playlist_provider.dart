import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/models/playlist.dart';

class Playlists with ChangeNotifier {
  final firestoreInstance = Firestore.instance;
  static List<Playlist> _playlists = [];
  var rng = new Random();

  List<Playlist> get playlists {
    return [..._playlists];
  }

  //Adding playlist for particular user
  Future<void> addInPlayList(
      {String email, String playlistId, String playName, String songId}) async {
    int playListIndex =
        _playlists.indexWhere((pl) => pl.playlistId == playlistId);
    int imgId = rng.nextInt(6) + 1;
    if (playListIndex < 0) {
      _playlists.add(
        Playlist(
          playlistId: playlistId,
          playlistName: playName,
          songId: [],
          imageUrl: 'assets/resources/pl${imgId.toString()}.jpg',
        ),
      );
      playListIndex =
          _playlists.indexWhere((pl) => pl.playlistId == playlistId);
    }
    _playlists[playListIndex].songId.add(songId);
    notifyListeners();
    try {
      print('create');
      final docRef = firestoreInstance
          .collection("Playlists")
          .document(email)
          .collection("Playlists")
          .add({
        'playlistName': playName,
      });
      docRef.then((value) {
        print(value.documentID);
        _playlists[playListIndex].playlistId = value.documentID;
        updateData(
            email: email,
            id: value.documentID,
            song: _playlists[playListIndex].songId);
      });
    } catch (error) {
      throw (error);
    }
  }

  //Updating the playlist for particular user
  Future<void> updateData(
      {String email, String id, String songId, List<String> song}) async {
    if (songId != null) {
      song.add(songId);
    }
    print(id);
    await firestoreInstance
        .collection("Playlists")
        .document(email)
        .collection("Playlists")
        .document(id)
        .updateData({
      'playlistId': id,
      'songId': song,
    });
  }

  //Fetching the playlist data
  Future<List<Playlist>> fetchData({String email}) async {
    if (email.isNotEmpty) {
      if (_playlists.isNotEmpty) {
        return _playlists;
      } else {
        final List<Playlist> pl = [];
        final snap = await firestoreInstance
            .collection('Playlists')
            .document(email)
            .collection('Playlists')
            .getDocuments();
        snap.documents.forEach((element) {
          print(element['songId']);
          print(element['playlistId']);
          print(element['playlistName']);
          int imgId = rng.nextInt(6) + 1;
          List<dynamic> val = element['songId'];
          List<String> newSong = [];
          for (int i = 0; i < val.length; i++) {
            newSong.add(val[i]);
          }
          pl.add(
            Playlist(
              playlistId: element['playlistId'],
              playlistName: element['playlistName'],
              songId: newSong,
              imageUrl: 'assets/resources/pl${imgId.toString()}.jpg',
            ),
          );
        });
        _playlists = pl;
        print(_playlists.length);
        return _playlists;
      }
    }
  }

  //Deleting the playlist
  Future<void> deletePlayList({String email, String playlistId}) async {
    int playListIndex =
        _playlists.indexWhere((pl) => pl.playlistId == playlistId);
    var playlist = _playlists[playListIndex];
    _playlists.removeAt(playListIndex);
    notifyListeners();

    try {
      await firestoreInstance
          .collection('Playlists')
          .document(email)
          .collection('Playlists')
          .document(playlistId)
          .delete();
      playlist = null;
    } catch (error) {
      _playlists.insert(playListIndex, playlist);
      notifyListeners();
      throw (error);
    }
  }

  //Delete all the playlist
  Future<void> deleteAllPlaylist({String email}) async {
    var plist = _playlists;
    try {
      clearPlaylist();
      await firestoreInstance.collection("Playlists").document(email).delete();
      plist = null;
    } catch (error) {
      _playlists = plist;
      notifyListeners();
      throw (error);
    }
  }

  //Clearing the playlist
  static clearPlaylist() {
    _playlists.clear();
  }
}
