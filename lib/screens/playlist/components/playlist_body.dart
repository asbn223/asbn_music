import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/models/playlist.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/song_list/song_list_screen.dart';
import 'package:provider/provider.dart';

class PlaylistBody extends StatelessWidget {
  void _showDialog(BuildContext context, String playlistId, String email) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: Text("Do you really want to delete this playlists?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
              FlatButton(
                onPressed: () {
                  Provider.of<Playlists>(context, listen: false)
                      .deletePlayList(email: email, playlistId: playlistId);
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context, listen: false);
    final user = Provider.of<Users>(context, listen: false).user;
    final size = MediaQuery.of(context).size;

    return Dismissible(
      key: ValueKey(playlist.playlistId),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete_forever,
          color: Colors.white,
          size: 30.0,
        ),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        _showDialog(context, playlist.playlistId, user[0].email);
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) {
              return SongListScreen(playlist.playlistId);
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.black26,
          ),
          width: (size.width),
          height: 150,
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 125,
                width: 125,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Hero(
                    tag: playlist.playlistId,
                    child: Image.asset(
                      playlist.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      playlist.playlistName,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.getFont(
                        'Berkshire Swash',
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      playlist.songId.length.toString() + " Songs",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Berkshire Swash',
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
