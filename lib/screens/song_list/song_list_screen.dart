import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/screens/song_list/components/song_list_body.dart';
import 'package:provider/provider.dart';

class SongListScreen extends StatelessWidget {
  static String routeName = 'song_list_screen';
  @override
  Widget build(BuildContext context) {
    final playlistId = ModalRoute.of(context).settings.arguments as String;
    final playlists = Provider.of<Playlists>(context, listen: false).playlists;
    final playlist = playlists.firstWhere((pl) => pl.playlistId == playlistId);
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.playlistName),
      ),
      body: ChangeNotifierProvider.value(
        value: playlist,
        child: SongListBody(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shuffle),
        onPressed: () {},
      ),
    );
  }
}
