import 'package:flutter/material.dart';

class Playlist with ChangeNotifier {
  String playlistId, playlistName, imageUrl;
  List<String> songId;

  Playlist({
    this.playlistId,
    this.playlistName,
    this.songId,
    this.imageUrl,
  });
}
