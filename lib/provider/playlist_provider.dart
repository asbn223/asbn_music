import 'package:flutter/material.dart';
import 'package:musicplayer/helper/save_file.dart';
import 'package:musicplayer/models/playlist.dart';

class Playlists with ChangeNotifier {
  List<Playlist> _playlists = [];

  List<Playlist> get playlists {
    return [..._playlists];
  }

  Future<void> addInPlayList(
      String playlistId, String playName, String songId) {
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
    SaveFile.writeToFile(
        playlistId: playlistId,
        playlistName: playName,
        songId: _playlists[playListIndex].songId);
  }

  Future<void> fetchPlaylist() async {
    if (_playlists.isNotEmpty) {
      return;
    }
    Map<String, dynamic> playlistContent = SaveFile.fileContent;

    int playListIndex = _playlists
        .indexWhere((pl) => pl.playlistId == playlistContent['playlistId']);
    if (playListIndex < 0) {
      _playlists.add(
        Playlist(
          playlistId: playlistContent['playlistId'],
          playlistName: playlistContent['playlistName'],
          songId: [],
        ),
      );
      playListIndex = _playlists
          .indexWhere((pl) => pl.playlistId == playlistContent['playlistId']);
//      print(playListIndex);
    }
    List<dynamic> newSong = playlistContent['songId'];
//    print(newSong);

    for (int i = 0; i < newSong.length; i++) {
      _playlists[playListIndex].songId.add(newSong[i].toString());
    }
    print(_playlists[playListIndex].songId);
    notifyListeners();
  }


}
