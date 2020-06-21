import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class AddToBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final playlists = Provider.of<Playlists>(context);
    final songId = ModalRoute.of(context).settings.arguments as String;
    print(songId);
    return Container(
      height: size.height,
      width: double.infinity,
      child: playlists.playlists.length == 0
          ? Center(
              child: Text('No Playlists'),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(playlists.playlists[index].playlistName),
                  onTap: () {
                    playlists.addInPlayList(
                        playlists.playlists[index].playlistId,
                        playlists.playlists[index].playlistName,
                        songId);
                  },
                );
              },
              itemCount: playlists.playlists.length,
            ),
    );
  }
}
