import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/now_playing/now_playing_screen.dart';
import 'package:provider/provider.dart';

class SongsList extends StatelessWidget {

  //Navigate to the selected routes
  void routeToNowPlaying(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return NowPlayingScreen(
            songId: id,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Song>(context, listen: false);
//    final songs = Provider.of<Songs>(context, listen: false);
    return GestureDetector(
      onTap: () {
        //Play the selected songs
        Songs.playSong(song.songFile);

        routeToNowPlaying(context, song.id);

        //Will show Notification with info of played song
        MediaNotification.showNotification(
          title: song.songName,
          author: song.artist,
          isPlaying: true,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        height: 200,
        width: 125,
        child: ClayContainer(
          borderRadius: 25,
          emboss: true,
          color: Colors.white,
          depth: 35,
          curveType: CurveType.convex,
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
                    child: Image.asset(
                      song.imgFile,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )),
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      song.songName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Raleway',
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                    ),
                    Text(
                      song.artist,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Parisienne',
                        fontSize: 11,
                        color: Color(0xFF8080800),
                      ),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
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
