import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/models/playlist.dart';
import 'package:musicplayer/provider/playlist_provider.dart';
import 'package:musicplayer/screens/song_list/song_list_screen.dart';
import 'package:provider/provider.dart';

class PlaylistBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Dismissible(
      key: ValueKey(playlist.playlistId),
      direction: DismissDirection.endToStart,
      background: Container(
//        padding: EdgeInsets.only(right: 10.0),
//        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Colors.red,
        child: Icon(
          Icons.delete_forever,
          color: Colors.white,
          size: 30.0,
        ),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        Provider.of<Playlists>(context, listen: false)
            .deletePlayList(playlistId: playlist.playlistId);
      },
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          SongListScreen.routeName,
          arguments: playlist.playlistId,
        ),
        child: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(50),
          ),
          width: (size.width),
          height: 200,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/resources/logo.png'),
                    image: AssetImage(
                      playlist.imageUrl,
                    ),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Center(
                child: Text(
                  playlist.playlistName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Berkshire Swash',
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
//          padding: EdgeInsets.only(left: 20.0, right: 20.0),
        ),
      ),
    );
  }
}
