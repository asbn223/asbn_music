import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/models/song.dart';
import 'package:provider/provider.dart';

class SongsList extends StatelessWidget {
  //create a new player
  final assetsAudioPlayer = AssetsAudioPlayer();

  void playSong(String songFile) {
    assetsAudioPlayer.stop();
    assetsAudioPlayer.open(
      Audio.file(songFile),
    );
  }
git
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Song>(context, listen: false);
    return GestureDetector(
      onTap: () => playSong(song.songFile),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        height: 200,
        width: 125,
        child: ClayContainer(
          borderRadius: 25,
          emboss: false,
          color: Colors.white,
          depth: 50,
          curveType: CurveType.convex,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/resources/logo.png'),
                      image: AssetImage(song.imgFile),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        song.songName,
                        style: GoogleFonts.getFont(
                          'Raleway',
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                      ),
                      Text(
                        song.artist,
                        style: GoogleFonts.getFont(
                          'Parisienne',
                          fontSize: 10,
                          color: Color(0xFF8080800),
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
