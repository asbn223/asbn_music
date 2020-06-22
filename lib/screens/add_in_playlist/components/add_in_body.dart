import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class AddToBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final playlists = Provider.of<Playlists>(context, listen: false);
    final songId = ModalRoute.of(context).settings.arguments as String;
    print(songId);
    return Container(
      height: size.height,
      width: double.infinity,
      child: FutureBuilder(
        future: playlists.fetchPlaylist(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
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
            );
          }
        },
      ),
    );
  }
}
