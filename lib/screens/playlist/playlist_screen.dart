import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/playlist/components/playlist_body.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatelessWidget {
  static String routeName = 'playlist_screen';

  @override
  Widget build(BuildContext context) {
    Playlists pl = Provider.of<Playlists>(context, listen: false);
    final user = Provider.of<Users>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists"),
      ),
      body: FutureBuilder(
        future: pl.fetchData(email: user[0].email),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: pl.playlists[index],
                      child: PlaylistBody(),
                    );
                  },
                  itemCount: pl.playlists.length,
                );
        },
      ),
    );
  }
}
