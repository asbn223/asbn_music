import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class AddToBody extends StatefulWidget {
  @override
  _AddToBodyState createState() => _AddToBodyState();
}

class _AddToBodyState extends State<AddToBody> {
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
        future: Provider.of<Playlists>(context, listen: false).fetchData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
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
                  itemCount: playlists.playlists.length,
                );
        },
      ),
    );
  }
}
