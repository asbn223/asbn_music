import 'package:flutter/material.dart';

class Song with ChangeNotifier {
  final String id, songName, artist, album, playlist, imgFile, songFile;
  bool isFav, isAdded;

  Song({
    @required this.id,
    @required this.songName,
    @required this.artist,
    @required this.album,
    @required this.songFile,
    @required this.imgFile,
    this.playlist,
    this.isFav = false,
    this.isAdded = false,
  });

  void toggleFav() {
    isFav = !isFav;
    notifyListeners();
  }

  void toggleAdded() {
    isAdded = !isAdded;
    notifyListeners();
  }
}
