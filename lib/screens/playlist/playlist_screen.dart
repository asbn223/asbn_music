import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/screens/playlist/components/playlist_body.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatefulWidget {
  static String routeName = 'playlist_screen';

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    Playlists pl = Provider.of<Playlists>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists"),
      ),
      body: FutureBuilder(
        future: pl.fetchData(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    print(snapshot.data);
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
