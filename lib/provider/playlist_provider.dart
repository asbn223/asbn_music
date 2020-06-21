import 'package:flutter/material.dart';
import 'package:musicplayer/models/playlist.dart';

class Playlists with ChangeNotifier {
//  Map<String, Map<String, List<String>>> _playlists = {};
  List<Playlist> _playlists = [];
//
//  Map<String, Map<String, List<String>>> get playlists {
//    return {..._playlists};
//  }

  List<Playlist> get playlists {
    return [..._playlists];
  }

//  void addInPlaylist(
////      {String playlistId, String playlistName, String songId}) async {
//    int playListIndex =
//        _playlists.indexWhere((pl) => pl.playlistId == playlistId);
////    print(playListIndex);
////    List<String> songs;
////
//////    final Song newSong = Song(
//////      id: song.id,
//////      songName: song.songName,
//////      songFile: song.songFile,
//////      artist: song.artist,
//////      album: song.album,
//////      imgFile: song.imgFile,
//////    );
////    songs.add(songId);
////    if (playListIndex < 0) {
////      print("play");
////      _playlists.add(
////        Playlist(
////            playlistId: playlistId, playlistName: playlistName, songId: [],),
////      );
//////      playListIndex =
//////          _playlists.indexWhere((pl) => pl.playlistId == playlistId);
////    }
//////    List<PlaylistInfo> playlistInfo = await Songs.audioQuery.getPlaylists();
//////    print(playlistInfo);
////  }

//  void addin(String playlistId, String playlistName, String songId) {
//    if (_playlists.containsKey(playlistId)) {
//      _playlists[playlistId][playlistName].add(songId);
//    } else {
//      _playlists = {
//        playlistId: {playlistName: []}
//      };
//      _playlists[playlistId][playlistName].add(songId);
//    }
//  }

  void addInPlayList(String playlistId, String playName, String songId) {
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
  }
}
