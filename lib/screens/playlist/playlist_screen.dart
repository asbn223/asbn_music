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
      Provider.of<Playlists>(context).fetchPlaylist().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlists>(context, listen: false).playlists;
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists"),
      ),
      body: Center(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: playlist[index],
                    child: PlaylistBody(),
                  );
                },
                itemCount: playlist.length,
              ),
      ),
    );
  }
}
