import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/models/song.dart';
import 'package:provider/provider.dart';

class BottomSongsList extends StatefulWidget {
  @override
  _BottomSongsListState createState() => _BottomSongsListState();
}

class _BottomSongsListState extends State<BottomSongsList> {
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Song>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: ClayContainer(
        depth: 35,
        emboss: true,
        curveType: CurveType.concave,
        height: 50,
        width: double.infinity,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                song.songName,
                style: GoogleFonts.getFont(
                  'Fredericka the Great',
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
              Text(
                song.artist,
                style: GoogleFonts.getFont(
                  'Playball',
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
