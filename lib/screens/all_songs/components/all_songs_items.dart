import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:musicplayer/models/song.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/provider/user_provider.dart';
import 'package:musicplayer/screens/now_playing/now_playing_screen.dart';
import 'package:provider/provider.dart';

class AllSongsItems extends StatefulWidget {
  @override
  _AllSongsItemsState createState() => _AllSongsItemsState();
}

class _AllSongsItemsState extends State<AllSongsItems> {
  @override
  Widget build(BuildContext context) {
    final song = Provider.of<Song>(context, listen: false);
    final songs = Provider.of<Songs>(context, listen: false);
    final user = Provider.of<Users>(context, listen: false);
    bool fav = song.isFav;
    return ListTile(
        title: Text(song.songName),
        subtitle: Text(song.artist),
        trailing: IconButton(
          icon: fav ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          onPressed: () {
            song.toggleFav();
            setState(() {
              fav = song.isFav;
            });
            print(fav);
            if (fav) {
              songs.fav(user.users[0].email, song.id);
            } else {
              songs.refav(user.users[0].email, song.id, fav);
            }
          },
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NowPlayingScreen(
              songId: song.id,
            );
          }));
          Songs.playSong(song.songFile);
          //Will show Notification with info of played song
          MediaNotification.showNotification(
            title: song.songName,
            author: song.artist,
            isPlaying: true,
          );
        });
  }
}
