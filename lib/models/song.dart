import 'package:flutter/material.dart';

class Song with ChangeNotifier {
  final String id, songName, artist, album, imgFile, songFile, duration;
  bool isFav;

  Song({
    @required this.id,
    @required this.songName,
    @required this.artist,
    @required this.album,
    @required this.songFile,
    @required this.imgFile,
    this.duration,
    this.isFav = false,
  });

  void toggleFav() {
    isFav = !isFav;
    notifyListeners();
  }
}
