import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/models/playlist.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/now_playing2/now_playing_screen2.dart';
import 'package:provider/provider.dart';

class SongListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pl = Provider.of<Playlist>(context, listen: false);
    final songs = Provider.of<Songs>(context, listen: false).songs;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height / 2 - 25,
            width: double.infinity,
            child: Hero(
              tag: pl.playlistId,
              child: Image.asset(
                pl.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(top: 25),
              height: size.height / 2 + 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final song =
                      songs.firstWhere((sng) => sng.id == pl.songId[index]);
                  return ListTile(
                    leading: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          song.imgFile,
                          fit: BoxFit.cover,
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    title: Text(
                      song.songName,
                      style: GoogleFonts.getFont(
                        'Megrim',
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite_border),
                      color: Color(0xFFFFFFFF),
                      onPressed: () {},
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return NowPlayingScreen2(
                            songId: song.id,
                            playlistId: pl.playlistId,
                          );
                        }),
                      );
                      Songs.playSong(song.songFile);
                      MediaNotification.showNotification(
                        title: song.songName,
                        author: song.artist,
                        isPlaying: true,
                      );
                    },
                  );
                },
                itemCount: pl.songId.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
