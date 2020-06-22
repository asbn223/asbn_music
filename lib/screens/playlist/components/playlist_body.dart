import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/models/playlist.dart';
import 'package:musicplayer/screens/song_list/song_list_screen.dart';
import 'package:provider/provider.dart';

class PlaylistBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playlist = Provider.of<Playlist>(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        SongListScreen.routeName,
        arguments: playlist.playlistId,
      ),
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        width: (size.width / 100) * 80,
        child: Text(
          playlist.playlistName,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            'Berkshire Swash',
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
      ),
    );
  }
}
