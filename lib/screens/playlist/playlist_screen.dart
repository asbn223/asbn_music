import 'package:flutter/material.dart';
import 'package:musicplayer/models/playlist.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Playlists"),
        ),
        body: FutureBuilder(
          future: Provider.of<Playlists>(context, listen: false).fetchData(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider<Playlist>(
                        create: (_) => snapshot.data[index],
                        child: PlaylistBody(),
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
          },
        ));
  }
}
