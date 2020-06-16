import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = true;

  @override
  void dispose() {
    super.dispose();
    _assetsAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songId = ModalRoute.of(context).settings.arguments as String;
    final songs = Provider.of<Songs>(context).songs;
    final song = songs.firstWhere((music) => music.id == songId);
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
            onPressed: null,
            color: Color(0xFF4B4B4B),
            iconColor: Color(0xFFFFFFFF),
          ),
        ),
        Positioned(
          bottom: 35,
          right: 35,
          child: ClayButton(
            icon: Icons.skip_next,
            onPressed: null,
            color: Color(0xFF4B4B4B),
            iconColor: Color(0xFFFFFFFF),
          ),
        ),
        widget.isOpened
            ? Text('')
            : Positioned(
                bottom: 35,
                left: size.width / 2 - 25,
                child: ClayButton(
                  icon: Icons.play_arrow,
                  onPressed: null,
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
                child: GestureDetector(
                  onTap: widget.isOpened ? () => print("sabin") : null,
                  child: Image.asset(
                    song.imgFile,
                    fit: BoxFit.cover,
                  ),
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
      ],
    );
  }
}
