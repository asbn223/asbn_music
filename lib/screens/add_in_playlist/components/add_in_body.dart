import 'package:flutter/material.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
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
    final user = Provider.of<Users>(context, listen: false).user;
    print(songId);
    return Container(
      height: size.height,
      width: double.infinity,
      child: FutureBuilder(
        future: Provider.of<Playlists>(context, listen: false).fetchData(
          email: user[0].email,
        ),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : playlists.playlists.length != 0
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(playlists.playlists[index].playlistName),
                          trailing: IconButton(
                            icon: Icon(Icons.sync),
                            onPressed: () {
//                      playlists.fetchData();
                              playlists.updateData(
                                email: user[0].email,
                                id: playlists.playlists[index].playlistId,
                                songId: songId,
                                song: playlists.playlists[index].songId,
                              );
                            },
                          ),
                          onTap: () {
                            playlists.updateData(
                              email: user[0].email,
                              id: playlists.playlists[index].playlistId,
                              songId: songId,
                              song: playlists.playlists[index].songId,
                            );
                          },
                        );
                      },
                      itemCount: playlists.playlists.length,
                    )
                  : Center(
                      child: Text("There are no playlists found!"),
                    );
        },
      ),
    );
  }
}
