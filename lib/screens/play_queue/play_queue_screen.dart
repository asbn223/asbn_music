import 'package:flutter/material.dart';
import 'package:musicplayer/screens/play_queue/components/play_queue_playlist.dart';

class PlayQueue extends StatelessWidget {
  static String routeName = 'play_queue_screen';

  final playlistId;
  PlayQueue({this.playlistId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Play Queue"),
      ),
      body: PlayQueuePlaylist(
        plId: playlistId,
      ),
    );
  }
}
