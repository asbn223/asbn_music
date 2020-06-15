import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/now_playing/components/Clay_Button.dart';
import 'package:provider/provider.dart';

class TopContainerBody extends StatelessWidget {
  final bool isOpened;

  TopContainerBody({this.isOpened});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songId = ModalRoute.of(context).settings.arguments as String;
    final songs = Provider.of<Songs>(context).songs;
    final song = songs.firstWhere((music) => music.id == songId);
    return Stack(
      children: <Widget>[
        isOpened
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
        AnimatedPositioned(
          duration: Duration(milliseconds: 750),
          top: isOpened ? 55 : 100,
          left: isOpened ? 95 : 45,
          child: AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isOpened ? 100 : 150),
            ),
            duration: Duration(milliseconds: 750),
            width: isOpened ? size.width / 2 : size.width / 2 + 100,
            height: isOpened ? size.height / 3.25 : size.height / 3.25 + 100,
            child: ClayContainer(
              depth: 50,
              borderRadius: isOpened ? 100 : 150,
              emboss: true,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isOpened ? 100 : 150),
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
          top: isOpened ? 115 : 15,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 750),
          child: ClayButton(
            icon: Icons.favorite_border,
            onPressed: isOpened ? null : null,
          ),
        ),
        AnimatedPositioned(
          right: 10,
          top: isOpened ? 115 : 15,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 750),
          child: ClayButton(
            icon: Icons.playlist_add,
            onPressed: isOpened ? null : null,
          ),
        ),

//        Positioned(
//          right: 10,
//          top: 15,
//          child: ClayButton(
//            icon: Icons.menu,
//            onPressed: () {
//              setState(() {
//                isPlaylistOpened = !isPlaylistOpened;
//              });
//            },
//          ),
//        ),
      ],
    );
  }
}
