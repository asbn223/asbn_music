import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/now_playing/components/clay_button.dart';
import 'package:provider/provider.dart';

class TopContainerBody extends StatefulWidget {
  final bool isOpened;

  TopContainerBody({this.isOpened});

  @override
  _TopContainerBodyState createState() => _TopContainerBodyState();
}

class _TopContainerBodyState extends State<TopContainerBody> {
  //this method is used for changing the icon of the play-pause accordingly

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String songId = ModalRoute.of(context).settings.arguments as String;
    Songs songs = Provider.of<Songs>(context, listen: false);
    Song song = songs.songs.firstWhere((music) => music.id == songId);
    int songIndex = songs.songs.indexOf(song);
    return Stack(
      children: <Widget>[
        widget.isOpened
            ? Text('')
            : Positioned(
                bottom: 140,
                child: AnimatedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  duration: Duration(milliseconds: 750),
                  child: Text(
                    song.songName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Monoton',
                      fontSize: 18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
        Positioned(
          bottom: 35,
          left: 35,
          child: ClayButton(
            icon: Icons.skip_previous,
            onPressed: () {
              songs.prevSong(songIndex - 1);
              songId = songs.songs[songIndex - 1].id;
              song = songs.songs.firstWhere((music) => music.id == songId);
              songIndex = songs.songs.indexOf(song);
            },
            color: Color(0xFF4B4B4B),
            iconColor: Color(0xFFFFFFFF),
          ),
        ),
        Positioned(
          bottom: 35,
          right: 35,
          child: ClayButton(
            icon: Icons.skip_next,
            onPressed: () {
              songs.nextSong(songIndex + 1);
              songId = songs.songs[songIndex + 1].id;
              song = songs.songs.firstWhere((music) => music.id == songId);
              songIndex = songs.songs.indexOf(song);
            },
            color: Color(0xFF4B4B4B),
            iconColor: Color(0xFFFFFFFF),
          ),
        ),
        widget.isOpened
            ? Text('')
            : Positioned(
                bottom: 35,
                left: size.width / 3,
                child: ClayButton(
                  icon: Icons.play_arrow,
                  onPressed: songs.playSong,
                  color: Color(0xFF4B4B4B),
                  iconColor: Color(0xFFFFFFFF),
                ),
              ),
        widget.isOpened
            ? Text('')
            : Positioned(
                bottom: 35,
                left: size.width / 1.8,
                child: ClayButton(
                  icon: Icons.pause,
                  onPressed: songs.pauseSong,
                  color: Color(0xFF4B4B4B),
                  iconColor: Color(0xFFFFFFFF),
                ),
              ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 750),
          top: widget.isOpened ? 55 : 100,
          left: widget.isOpened ? 95 : 45,
          child: AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.isOpened ? 100 : 150),
            ),
            duration: Duration(milliseconds: 750),
            width: widget.isOpened ? size.width / 2 : size.width / 2 + 100,
            height:
                widget.isOpened ? size.height / 3.25 : size.height / 3.25 + 100,
            child: ClayContainer(
              depth: 50,
              borderRadius: widget.isOpened ? 100 : 150,
              emboss: true,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(widget.isOpened ? 100 : 150),
                child: Image.asset(
                  song.imgFile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          left: 10,
          top: widget.isOpened ? 115 : 15,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 750),
          child: ClayButton(
            icon: Icons.favorite_border,
            onPressed: widget.isOpened ? null : null,
            color: Color(0xFFFFBE76),
            iconColor: Color(0xFFFFFFFF),
          ),
        ),
        AnimatedPositioned(
          right: 10,
          top: widget.isOpened ? 115 : 15,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 750),
          child: ClayButton(
            icon: Icons.playlist_add,
            onPressed: widget.isOpened ? null : null,
            color: Color(0xFFFF7979),
            iconColor: Color(0xFFFFFFFF),
          ),
        ),
        AnimatedPositioned(
          left: widget.isOpened ? 75 : 10,
          top: 15,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 750),
          child: ClayButton(
            icon: Icons.play_arrow,
            onPressed: songs.playSong,
            color: Color(0xFF4B4B4B),
            iconColor: Color(0xFFFFFFFF),
          ),
        ),
        AnimatedPositioned(
          right: widget.isOpened ? 75 : 10,
          top: 15,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 750),
          child: ClayButton(
            icon: Icons.pause,
            onPressed: songs.pauseSong,
            color: Color(0xFF4B4B4B),
            iconColor: Color(0xFFFFFFFF),
          ),
        ),
      ],
    );
  }
}
