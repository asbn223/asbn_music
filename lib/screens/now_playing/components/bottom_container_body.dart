import 'package:flutter/material.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:provider/provider.dart';

class BottomContainerBody extends StatelessWidget {
  Widget songDetailContainer({
    BuildContext context,
    Size size,
    String label,
    String songDetail,
  }) {
    return Flexible(
      child: NeuomorphicContainer(
        margin: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color.fromRGBO(209, 205, 199, 1.0),
              width: 2.0,
            ),
          ),
          width: ((size.width / 100) * 80),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      label + ": ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      songDetail,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
        ),
        height: 50.0,
        borderRadius: BorderRadius.circular(10.0),
        border:
            Border.all(color: Color.fromRGBO(239, 238, 238, 1.0), width: 3.0),
        color: Theme.of(context).accentColor,
        style: NeuomorphicStyle.Flat,
        intensity: 0.2,
        offset: Offset(10.0, 10.0),
        blur: 7,
      ),
      flex: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songs = Provider.of<Songs>(context).songs;
    final songId = ModalRoute.of(context).settings.arguments as String;
    final song = songs.firstWhere((so) => so.id == songId);
    return Column(
      children: <Widget>[
        songDetailContainer(
          context: context,
          size: size,
          label: "Song Name",
          songDetail: song.songName,
        ),
        songDetailContainer(
          context: context,
          size: size,
          label: "Artist",
          songDetail: song.artist,
        ),
        songDetailContainer(
          context: context,
          size: size,
          label: "Album",
          songDetail: song.album,
        ),
      ],
    );
  }
}
