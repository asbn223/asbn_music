import 'package:flutter/material.dart';

class Playlist with ChangeNotifier {
  final String playlistId, playlistName;
  List<String> songId;

  Playlist({
    this.playlistId,
    this.playlistName,
    this.songId,
  });
}
