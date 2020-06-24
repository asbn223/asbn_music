import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/models/playlist.dart';

class Playlists with ChangeNotifier {
  final firestoreInstance = Firestore.instance;
  List<Playlist> _playlists = [];
  var rng = new Random();

  List<Playlist> get playlists {
    return [..._playlists];
  }

  Future<void> addInPlayList(
      String playlistId, String playName, String songId) async {
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
      final docRef = firestoreInstance.collection("playlists").add({
        'playlistName': playName,
      });
      docRef.then((value) {
        _playlists[playListIndex].playlistId = value.documentID;
        updateData(
            id: value.documentID, song: _playlists[playListIndex].songId);
      });
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateData({String id, String songId, List<String> song}) async {
    if (songId != null) {
      song.add(songId);
    }
    await firestoreInstance
        .collection("playlists")
        .document(id)
        .updateData({'playlistId': id, 'songId': song});
  }

  Future<List<Playlist>> fetchData() async {
    if (_playlists.isNotEmpty) {
      print("what");
      return _playlists;
    } else {
      final List<Playlist> pl = [];
      final snap =
          await firestoreInstance.collection('playlists').getDocuments();
      print(snap.documents);
      snap.documents.forEach((element) {
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

      return _playlists;
    }
  }

  Future<void> deletePlayList({String playlistId}) {
    int playListIndex =
        _playlists.indexWhere((pl) => pl.playlistId == playlistId);
    var playlist = _playlists[playListIndex];
    _playlists.removeAt(playListIndex);
    notifyListeners();

    try {
      firestoreInstance.collection('playlists').document(playlistId).delete();
      playlist = null;
    } catch (error) {
      _playlists.insert(playListIndex, playlist);
      notifyListeners();
      throw (error);
    }
  }
}
