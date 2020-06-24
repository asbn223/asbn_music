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
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Playlists>(context).fetchData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<Playlists>(
              builder:
                  (BuildContext context, Playlists playlist, Widget child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: playlist.playlists[index],
                      child: PlaylistBody(),
                    );
                  },
                  itemCount: playlist.playlists.length,
                );
              },
            ),
    );
  }
}
