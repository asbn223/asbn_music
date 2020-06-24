import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/models/playlist.dart';

class Playlists with ChangeNotifier {
  final firestoreInstance = Firestore.instance;
  List<Playlist> _playlists = [];

  List<Playlist> get playlists {
    return [..._playlists];
  }

  Future<void> addInPlayList(
      String playlistId, String playName, String songId) async {
    int playListIndex =
        _playlists.indexWhere((pl) => pl.playlistId == playlistId);

    if (playListIndex < 0) {
      _playlists.add(
        Playlist(
          playlistId: playlistId,
          playlistName: playName,
          songId: [],
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

//  Future<void> onSync(String playlistId, String playName) async {
//    print('pressed');
//    int playListIndex =
//        _playlists.indexWhere((pl) => pl.playlistId == playlistId);
//    print(playlistId);
//    final docRef = await firestoreInstance.collection("playlists");
//    print(docRef.document(playlistId).documentID);
//    if (docRef.document(playlistId).documentID == playlistId) {
//      print('only update');
//      updateData(docRef.document(playlistId).documentID,
//          _playlists[playListIndex].songId);
//      fetchData();
//    }
//  }

  Future<void> updateData({String id, String songId, List<String> song}) async {
    if (songId != null) {
      song.add(songId);
    }
    await firestoreInstance
        .collection("playlists")
        .document(id)
        .updateData({'playlistId': id, 'songId': song});
  }

//  Future<void> fetchPlaylist() async {
//    if (_playlists.isNotEmpty) {
//      return;
//    }
//    List<Map<String, dynamic>> playlistContent = SaveFile.fileContent;
//    print(playlistContent);
//    int playListIndex = _playlists
//        .indexWhere((pl) => pl.playlistId == playlistContent['playlistId']);
//    if (playListIndex < 0) {
//      _playlists.add(
//        Playlist(
//          playlistId: playlistContent['playlistId'],
//          playlistName: playlistContent['playlistName'],
//          songId: [],
//        ),
//      );
//
//      playListIndex = _playlists
//          .indexWhere((pl) => pl.playlistId == playlistContent['playlistId']);
////      print(playListIndex);
//    }
//    List<dynamic> newSong = playlistContent['songId'];
////    print(newSong);
//
//    for (int j = 0; j < _playlists.length; j++) {
//      for (int i = 0; i < newSong.length; i++) {
//        _playlists[j].songId.add(newSong[i].toString());
//      }
//    }
//
//    print(_playlists[playListIndex].songId);
//    notifyListeners();
//  }

  Future<void> fetchData() async {
    if (_playlists.isNotEmpty) {
      print("what");
      return null;
    } else {
      final List<Playlist> pl = [];
      final snap = firestoreInstance.collection('playlists').getDocuments();
      snap.then((QuerySnapshot value) => value.documents.forEach((element) {
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
              ),
            );
          }));
      _playlists = pl;
    }
  }
}
