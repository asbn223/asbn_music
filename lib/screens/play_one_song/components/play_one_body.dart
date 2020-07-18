import 'package:diagonal/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/provider/setting_provider.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/widgets/clay_button.dart';
import 'package:musicplayer/widgets/search/search_items.dart';
import 'package:provider/provider.dart';

class PlayOneBody extends StatefulWidget {
  @override
  _PlayOneBodyState createState() => _PlayOneBodyState();
}

class _PlayOneBodyState extends State<PlayOneBody> {
  String status = 'hidden';

  @override
  void initState() {
    super.initState();

    //Set Notification to Pause and song will be paused
    MediaNotification.setListener('pause', () {
      setState(() => status = 'pause');
      Songs.pauseSong();
    });

    //Set Notification to Play and song will be played
    MediaNotification.setListener('play', () {
      setState(() => status = 'play');
      Songs.resumeSong();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final id = ModalRoute.of(context).settings.arguments as String;
    final user = Provider.of<Users>(context, listen: false);
    final darkMode = Provider.of<Settings>(context, listen: false).isDarkMode;
    final songs = Provider.of<Songs>(context, listen: false);
    final song = songs.songs.firstWhere((element) => element.id == id);
    bool fav = song.isFav;
    return Container(
      height: size.height,
      width: double.infinity,
      color: Theme.of(context).accentColor,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: <Widget>[
                ClayButton(
                  color: Colors.blue,
                  icon: Icons.chevron_left,
                  onPressed: () => Navigator.of(context).pop(),
                  iconColor: Colors.white,
                ),
                SizedBox(
                  width: 45,
                ),
                Text(
                  "Now Playing",
                  style: GoogleFonts.getFont(
                    "Frijole",
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                ClayButton(
                  color: Colors.blue,
                  icon: Icons.search,
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SearchItems(),
                    );
                  },
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(0, -0.55),
            child: Container(
              height: size.height / 2.25,
              width: double.infinity,
              child: Image.asset(
                song.imgFile,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height / 2.5,
              color: Colors.red,
              child: Row(
                children: <Widget>[
                  Diagonal(
                    child: Container(
                      height: size.height / 2.5,
                      width: size.width / 2,
                      color: Colors.black,
                    ),
                    clipHeight: 250.0,
                  ),
                  Diagonal(
                    child: Container(
                      height: size.height / 2.5,
                      width: size.width / 2,
                      color: Colors.white,
                    ),
                    clipHeight: 250.0,
                    position: Position.TOP_RIGHT,
                  ),
//                  Container(
//                    height: size.height / 2.5,
//                    width: size.width / 2,
//                    color: Colors.white,
//                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.1, 0.5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 1.8,
                ),
              ),
              width: 325,
              height: 100,
              child: ListTile(
                title: Text(
                  song.songName,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  song.artist,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  color: Colors.white,
                  icon:
                      fav ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                  onPressed: () {
                    song.toggleFav();
                    setState(() {
                      fav = song.isFav;
                    });
                    if (fav) {
                      songs.fav(user.user[0].email, song.id);
                    } else {
                      songs.refav(user.user[0].email, song.id, fav);
                    }
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.25, 0.8),
            child: ClayButton(
              color: Colors.black,
              iconColor: Colors.white,
              onPressed: () {
                Songs.pauseSong();
                MediaNotification.showNotification(
                  title: song.songName,
                  author: song.artist,
                  isPlaying: false,
                );
              },
              icon: Icons.pause,
            ),
          ),
          Align(
            alignment: Alignment(-0.25, 0.8),
            child: ClayButton(
              color: Colors.white,
              iconColor: Colors.black,
              onPressed: () {
                Songs.resumeSong();
                MediaNotification.showNotification(
                  title: song.songName,
                  author: song.artist,
                  isPlaying: true,
                );
              },
              icon: Icons.play_arrow,
            ),
          ),
        ],
      ),
    );
  }
}
