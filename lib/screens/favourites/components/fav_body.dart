import 'package:flutter/material.dart';
import 'package:musicplayer/provider/songs_provider.dart';
import 'package:musicplayer/screens/all_songs/components/all_songs_items.dart';
import 'package:provider/provider.dart';

class FavBody extends StatelessWidget {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final songs = Provider.of<Songs>(context, listen: false).songs;
    final favSong = songs.where((element) => element.isFav).toList();
    return Container(
      height: size.height,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ChangeNotifierProvider.value(
            value: favSong[index],
            child: AllSongsItems(),
          );
        },
        itemCount: favSong.length,
      ),
    );
  }
}
