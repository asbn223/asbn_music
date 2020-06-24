import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class AddToBody extends StatefulWidget {
  @override
  _AddToBodyState createState() => _AddToBodyState();
}

class _AddToBodyState extends State<AddToBody> {
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
    final size = MediaQuery.of(context).size;
    final songId = ModalRoute.of(context).settings.arguments as String;
    print(songId);
    return Container(
      height: size.height,
      width: double.infinity,
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<Playlists>(
              builder:
                  (BuildContext context, Playlists playlists, Widget child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(playlists.playlists[index].playlistName),
                      trailing: IconButton(
                        icon: Icon(Icons.sync),
                        onPressed: () {
//                      playlists.fetchData();
                          playlists.updateData(
                            id: playlists.playlists[index].playlistId,
                            songId: songId,
                            song: playlists.playlists[index].songId,
                          );
                        },
                      ),
                      onTap: () {
                        playlists.updateData(
                          id: playlists.playlists[index].playlistId,
                          songId: songId,
                          song: playlists.playlists[index].songId,
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
